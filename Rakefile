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
# OUTPUT_DIR = 'docs'
OUTPUT_DIR = 'www'

# Inputs
INPUT_POST_FILES = FileList["#{INPUT_DIR}/posts/**/*.md"]
INPUT_NON_POST_FILES = FileList["#{INPUT_DIR}/non_posts/**/*.md"]
INPUT_STATIC_FILES = FileList["#{STATIC_DIR}/*"]

# Intermediate files
CACHE_POST_FILES = INPUT_POST_FILES.pathmap("%{^#{INPUT_DIR}/,#{CACHE_DIR}/}X.html")
CACHE_NON_POST_FILES = INPUT_NON_POST_FILES.pathmap("%{^#{INPUT_DIR}/,#{CACHE_DIR}/}X.html")
CACHE_TAG_FILES_GLOB = "#{CACHE_DIR}/tags/**/index.jsonl".freeze
CACHE_RSS_FILE = "#{CACHE_DIR}/rss_feed.jsonl".freeze

# Final output files
OUTPUT_POST_FILES = INPUT_POST_FILES.pathmap("%{^#{INPUT_DIR}/,#{OUTPUT_DIR}/}X/index.html")
OUTPUT_NON_POST_FILES = CACHE_NON_POST_FILES.pathmap("%{^##{CACHE_DIR}/non_posts/,#{OUTPUT_DIR}/}X.html")
OUTPUT_STATIC_FILES = INPUT_STATIC_FILES.pathmap("%{^#{STATIC_DIR}/,#{OUTPUT_DIR}/}p")
OUTPUT_TAG_FEEDS = FileList["#{OUTPUT_DIR}/tags/*.xml"]
OUTPUT_TAG_PAGES = FileList["#{OUTPUT_DIR}/tags/*.html"]
OUTPUT_SITE_INDEX = "#{OUTPUT_DIR}/index.html".freeze
OUTPUT_RSS_FILE_PATH = "#{OUTPUT_DIR}/#{RSS_FILENAME}".freeze
OUTPUT_SITEMAP_FILE = "#{OUTPUT_DIR}/sitemap.xml".freeze

CLEAN << CACHE_DIR
CLOBBER << OUTPUT_DIR

# since tag files are appended to, potentially in parallel, during the caching
# phase, a mutex is needed to ensure files are not simultaneously modified,
# which could corrupt data.
tag_lock = Thread::Mutex.new
rss_lock = Thread::Mutex.new

directory "#{CACHE_DIR}/tags"
directory "#{OUTPUT_DIR}/tags"

(
  CACHE_POST_FILES +
  CACHE_NON_POST_FILES +
  OUTPUT_POST_FILES +
  OUTPUT_NON_POST_FILES +
  OUTPUT_STATIC_FILES
).each do |fpath|
  directory fpath.pathmap('%d')
end

# We list these explicitly instead of using a rule because the static output
# runs the risk of matching everything.
OUTPUT_STATIC_FILES.each do |fpath|
  file(fpath => [fpath.pathmap("%{^#{OUTPUT_DIR}/,#{STATIC_DIR}/}p"), fpath.pathmap('%d')]) do |t|
    cp t.source, t.name
  end
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
    File.write(CACHE_RSS_FILE, entry, mode: 'a')
  end

  parsed.front_matter.fetch('tags', []).each do |tag|
    conformed_tag = tag.downcase.gsub(' ', '-')
    tag_dir = "#{CACHE_DIR}/tags/#{conformed_tag}"
    tag_file = "#{tag_dir}/index.jsonl"

    # Ensure the directories for tags get created.
    directory tag_dir
    directory tag_dir.pathmap("%{^#{CACHE_DIR}/,#{OUTPUT_DIR}/}p")
    Rake::Task[tag_dir].invoke

    p "#{t.name} >> #{tag_file}"
    tag_lock.synchronize do
      File.write(tag_file, entry, mode: 'a')
    end
  end
end

def make_rss(to_read, to_write, url_path, mutex) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  require 'rss'
  require 'json'
  require 'front_matter_parser'

  rendered_rss = RSS::Maker.make('atom') do |maker|
    maker.channel.author = MAIN_SITE_AUTHOR
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "#{BASE_URL}/#{url_path}"
    maker.channel.title = SITE_TITLE

    file_guts = mutex.synchronize { File.read(to_read) }
    blobs = file_guts.each_line.map { |l| JSON.parse(l) }
    blobs_sorted = (blobs.sort_by { |e| e.dig('front_matter', 'date') }).reverse
    blobs_sorted.each do |jblob|
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

  p "#{to_read} -> #{to_write}"
  File.write(to_write, rendered_rss)
end

# TODO: make a rule like this to generate HTML index files for tags.
rule(%r{^#{OUTPUT_DIR}/tags/.*/index\.xml$} => [
       proc { |tn| tn.pathmap("%{^#{OUTPUT_DIR}/,#{CACHE_DIR}/}X.jsonl") }
     ]) do |t|
  url_path = t.name.pathmap("%{^#{OUTPUT_DIR}/,}p")
  make_rss(t.source, t.name, url_path, tag_lock)
end

rule(_gen_tag_feeds: proc { FileList[CACHE_TAG_FILES_GLOB].pathmap("%{^#{CACHE_DIR}/,#{OUTPUT_DIR}/}X.xml") }) do |t|
  # p "Did #{t.name} get called?"
  # p "What are the prereqs? #{t.prerequisites}"
  # p "What are the sources? #{t.sources}"
end

# These are generated as a side effect of generating the main RSS file
rule(%r{^#{OUTPUT_DIR}/tags/.*\.jsonl$} => [CACHE_RSS_FILE]) do |t|
  p "Did #{t.name} get called?"
  p "What are the prereqs? #{t.prerequisites}"
  p "What are the sources? #{t.sources}"
end

file OUTPUT_RSS_FILE_PATH => [CACHE_RSS_FILE] do |t|
  make_rss(t.source, t.name, RSS_FILENAME, rss_lock)
end

file OUTPUT_SITE_INDEX => (OUTPUT_NON_POST_FILES + OUTPUT_STATIC_FILES)

file CACHE_RSS_FILE => CACHE_POST_FILES

desc 'Compile site parts'
task compile: (CACHE_POST_FILES + CACHE_NON_POST_FILES + FileList[CACHE_RSS_FILE])

task _build_internal: [OUTPUT_SITE_INDEX, OUTPUT_RSS_FILE_PATH]

desc 'Build site'
task :build do
  # These must run sequentially, so they are run explicitly within a task.
  Rake::Task[:compile].invoke
  Rake::Task[:_build_internal].invoke
  Rake::Task[:_gen_tag_feeds].invoke
end

desc 'Build site'
task default: [:build]

# Convenience tasks
desc 'Install dependencies via bundler'
task :install_deps do
  sh 'bundle install'
end

desc 'Preview site'
task :preview do
  require 'launchy'

  Thread.start do
    sleep(2)
    Launchy.open('http://0.0.0.0:5000')
  end

  # https://x.com/tenderlove/status/351554818579505152
  ruby '-run', '-e', 'httpd', OUTPUT_DIR, '-p5000'
end
