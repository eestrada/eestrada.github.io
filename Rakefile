# frozen_string_literal: true

require 'rake/clean'

# Just always multitask, because why not?
Rake.application.options.always_multitask = true

# Change these constants to pull from elsewhere

BASE_URL = 'https://www.misterfidget.com'
MAIN_SITE_AUTHOR = 'Ethan Estrada'
SITE_TITLE = 'Ethan Estrada'
RSS_FILENAME = 'index.xml'

# Where the markdown files live.
INPUT_DIR = 'content'

# Where images, CSS, and other static files live.
STATIC_DIR = 'static'

# For intermediate build files.
CACHE_DIR = 'cache'

# Where final output goes.
OUTPUT_DIR = 'docs'

# Inputs
INPUT_POST_FILES = FileList["#{INPUT_DIR}/posts/**/*.md"]
INPUT_NON_POST_FILES = FileList["#{INPUT_DIR}/non_posts/**/*.md"]
INPUT_STATIC_FILES = FileList["#{STATIC_DIR}/*"]

# Intermediate files
CACHE_POST_FILES = INPUT_POST_FILES.pathmap("%{^#{INPUT_DIR}/,#{CACHE_DIR}/}X.html")
CACHE_NON_POST_FILES = INPUT_NON_POST_FILES.pathmap("%{^#{INPUT_DIR}/,#{CACHE_DIR}/}X.html")
CACHE_TAG_FILES = FileList["#{CACHE_DIR}/tags/*.jsonl"]
CACHE_RSS_FILE = "#{CACHE_DIR}/rss_feed.jsonl".freeze

# Final output files
OUTPUT_POST_FILES = INPUT_POST_FILES.pathmap("%{^#{INPUT_DIR}/,#{OUTPUT_DIR}/}X/index.html")
OUTPUT_NON_POST_FILES = CACHE_NON_POST_FILES.pathmap("%{^##{CACHE_DIR}/non_posts/,#{OUTPUT_DIR}/}X.html")
OUTPUT_STATIC_FILES = INPUT_STATIC_FILES.pathmap("%{^#{STATIC_DIR}/,#{OUTPUT_DIR}/}p")
SITE_INDEX = "#{OUTPUT_DIR}/index.html".freeze
RSS_FILE_PATH = "#{OUTPUT_DIR}/#{RSS_FILENAME}".freeze
SITEMAP_FILE = "#{OUTPUT_DIR}/sitemap.xml".freeze

CLEAN << CACHE_DIR
CLOBBER << OUTPUT_DIR

# since tag files are appended to, potentially in parallel, during the caching
# phase, a mutex is needed to ensure files are not simultaneously modified,
# which could corrupt data.
tag_lock = Thread::Mutex.new
rss_lock = Thread::Mutex.new

directory "#{CACHE_DIR}/tags"

(
  CACHE_POST_FILES +
  CACHE_NON_POST_FILES +
  OUTPUT_POST_FILES +
  OUTPUT_NON_POST_FILES +
  OUTPUT_STATIC_FILES
).each do |fpath|
  directory fpath.pathmap('%d')
end

# From input Markdown to cached HTML and tags
rule(%r{^#{CACHE_DIR}/posts/.*\.html$} => [
       proc { |tn| tn.pathmap("%{^#{CACHE_DIR}/,#{INPUT_DIR}/}X.md") },
       proc { |tn| tn.pathmap('%d') }
]) do |t|
  require 'json'
  require 'tilt/erb'
  require 'tilt/kramdown'
  require 'front_matter_parser'

  p "#{t.source} -> #{t.name}"

  parsed = FrontMatterParser::Parser.parse_file(t.source)
  rendered_html = Kramdown::Document.new(parsed.content).to_html
  File.write(t.name, rendered_html)

  entry_hash = { 'name': t.name, 'front_matter': parsed.front_matter }
  entry = "#{JSON.dump(entry_hash)}\n"
  rss_lock.synchronize do
    File.write(CACHE_RSS_FILE, "#{entry}\n", mode: 'a')
  end

  parsed.front_matter.fetch('tags', []).each do |tag|
    conformed_tag = tag.downcase.gsub(' ', '-')
    tag_dir = "#{CACHE_DIR}/tags"
    tag_file = "#{tag_dir}/#{conformed_tag}.jsonl"
    p "#{t.name} >> #{tag_file}"
    Rake::Task[tag_dir].invoke
    tag_lock.synchronize do
      File.write(tag_file, "#{entry}\n", mode: 'a')
    end
  end
end

file RSS_FILE_PATH => [CACHE_RSS_FILE] do |t|
  require 'rss'
  require 'front_matter_parser'

  rendered_rss = RSS::Maker.make('atom') do |maker|
    maker.channel.author = MAIN_SITE_AUTHOR
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "#{BASE_URL}/#{RSS_FILENAME}"
    maker.channel.title = SITE_TITLE

    file_guts = rss_lock.synchronize { File.read(t.source) }
    file_guts.each_line.map { |l| JSON.load(l) }.each do |jblob|
      fpath = jblob['name']
      front_matter = jblob['front_matter']
      maker.items.new_item do |item|
        item.author = front_matter['Author']
        item.link = "#{BASE_URL}/#{fpath.pathmap("%{#{CACHE_DIR}/,}X/")}"
        item.title = front_matter['title']
        item.date = front_matter['date']
        item.updated = front_matter['lastmod'] if front_matter['lastmod']
      end
    end
  end

  p "#{t.source} -> #{t.name}"
  File.write(t.name, rendered_rss)
end

file SITE_INDEX => (OUTPUT_NON_POST_FILES + OUTPUT_STATIC_FILES)

file CACHE_RSS_FILE => CACHE_POST_FILES

desc 'Compile site parts'
task compile: (CACHE_POST_FILES + CACHE_NON_POST_FILES + FileList[CACHE_RSS_FILE])

desc 'Build site'
task build: [SITE_INDEX, RSS_FILE_PATH]

desc 'Build site'
task default: [:build]

# Convenience tasks
desc 'Install dependencies via bundler'
task :install_deps do
  sh 'bundle install'
end

desc 'Preview site'
task :preview do
  # https://x.com/tenderlove/status/351554818579505152
  ruby '-run', '-e', 'httpd', OUTPUT_DIR, '-p5000'
end
