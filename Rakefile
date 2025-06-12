# frozen_string_literal: true

require 'rake/clean'

# Just always multitask, because why not?
Rake.application.options.always_multitask = true

# Change these constants to pull from elsewhere

BASE_URL = 'https://www.misterfidget.com'
MAIN_SITE_AUTHOR = 'Ethan Estrada'
SITE_TITLE = 'Ethan Estrada'

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
CACHE_POST_FILES = INPUT_POST_FILES.pathmap("%{^#{INPUT_DIR},#{CACHE_DIR}}X/index.html")

# FIXME: this doesn't strip off the `non_posts` prefix from the path.
CACHE_NON_POST_FILES = INPUT_NON_POST_FILES.pathmap("%{^#{INPUT_DIR},#{CACHE_DIR}}X/index.html")

CACHE_TAG_FILES = FileList["#{CACHE_DIR}/tags/*.txt"]

# Final output files
OUTPUT_POST_FILES = INPUT_POST_FILES.pathmap("%{^#{INPUT_DIR},#{OUTPUT_DIR}}X/index.html")
OUTPUT_STATIC_FILES = INPUT_STATIC_FILES.pathmap("%{^#{STATIC_DIR},#{OUTPUT_DIR}}p")
SITE_INDEX = "#{OUTPUT_DIR}/index.html".freeze
RSS_FILENAME = 'index.xml'
RSS_FILE_PATH = "#{OUTPUT_DIR}/#{RSS_FILENAME}".freeze
SITEMAP_FILE = "#{OUTPUT_DIR}/sitemap.xml".freeze

CLEAN << CACHE_DIR
CLOBBER << OUTPUT_DIR

# since tag files are appended to, potentially in parallel, during the caching
# phase, a mutex is needed to ensure files are not simultaneously modified,
# which could corrupt data.
_tag_lock = Thread::Mutex.new

directory CACHE_DIR
directory OUTPUT_DIR

OUTPUT_STATIC_FILES.each do |e|
  src = e.pathmap("%{^#{OUTPUT_DIR},#{STATIC_DIR}}p")
  dirp = e.pathmap('%d')
  directory dirp

  file e => [dirp, src] do |t|
    cp src, t.name
  end
end

OUTPUT_POST_FILES.each do |e|
  src = e.pathmap("%{^#{OUTPUT_DIR},#{INPUT_DIR}}d.md")
  dirp = e.pathmap('%d')
  directory dirp

  file e => [dirp, src] do |t|
    require 'tilt/erb'
    require 'tilt/kramdown'
    require 'front_matter_parser'

    p "#{src} -> #{t.name}"

    # TODO: use layout file and Tilt to wrap content.
    parsed = FrontMatterParser::Parser.parse_file(src)
    rendered_html = Kramdown::Document.new(parsed.content).to_html
    File.write(t.name, rendered_html)
  end
end

rule %r{^#{CACHE_DIR}/tags/.*\\.txt$} => [proc { |tn| tn.pathmap("%{^#{CACHE_DIR}}X/index.html") }] do |t|
end

file RSS_FILE_PATH => OUTPUT_POST_FILES do |t|
  require 'rss'
  require 'front_matter_parser'

  rendered_rss = RSS::Maker.make('atom') do |maker|
    maker.channel.author = MAIN_SITE_AUTHOR
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "#{BASE_URL}/#{RSS_FILENAME}"
    maker.channel.title = SITE_TITLE

    INPUT_POST_FILES.each do |e|
      parsed = FrontMatterParser::Parser.parse_file(e)
      front_matter = parsed.front_matter
      maker.items.new_item do |item|
        item.author = front_matter['Author']
        item.link = "#{BASE_URL}/#{e.pathmap("%{#{INPUT_DIR}/,}X/")}"
        item.title = front_matter['title']
        item.date = front_matter['date']
        item.updated = front_matter['lastmod'] if front_matter['lastmod']
      end
    end
  end

  # p t.name
  # p rendered_rss
  # p t.name

  p "-> #{t.name}"
  File.write(t.name, rendered_rss)
end

# TODO: add task to build tag outputs

# TODO: add task to generate main index.html
file SITE_INDEX => (OUTPUT_POST_FILES + OUTPUT_STATIC_FILES) do |t|
  p "-> #{t.name}"
  # How to append to a file in Ruby: https://stackoverflow.com/a/71481898
  File.write(t.name, "Another line!\n", mode: 'a+')
end

desc 'Compile site parts'
task compile: []

desc 'Build site'
task build: [SITE_INDEX, RSS_FILE_PATH]

desc 'Build site'
task default: [:build]

desc 'Install dependencies via bundler'
task :install_deps do
  sh 'bundle install'
end

desc 'Preview site'
task :preview do
  ruby '-run', '-e', 'httpd', OUTPUT_DIR, '-p5000'
end
