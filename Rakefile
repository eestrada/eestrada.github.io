# frozen_string_literal: true

require 'rake/clean'

# Change these constants to pull from elsewhere

BASE_URL = 'https://www.misterfidget.com'
MAIN_SITE_AUTHOR = 'Ethan Estrada'
SITE_TITLE = 'Ethan Estrada'

# Where the markdown files live.
INPUT_DIR = 'content'

# Where images, CSS, and other static files live.
STATIC_DIR = 'static'

# For intermediate build files.
BUILD_DIR = 'build'

# Where final output goes.
OUTPUT_DIR = 'docs'

INPUT_FILES = FileList["#{INPUT_DIR}/**/*.md"]
BUILD_FILES = INPUT_FILES.pathmap("%{^#{INPUT_DIR},#{BUILD_DIR}}X/index.html")
OUTPUT_FILES = INPUT_FILES.pathmap("%{^#{INPUT_DIR},#{OUTPUT_DIR}}X/index.html")
STATIC_FILES = FileList["#{STATIC_DIR}/*"]
STATIC_OUTPUT_FILES = STATIC_FILES.pathmap("%{^#{STATIC_DIR},#{OUTPUT_DIR}}p")
RSS_FILE = "#{OUTPUT_DIR}/index.xml".freeze
SITEMAP_FILE = "#{OUTPUT_DIR}/sitemap.xml".freeze

CLEAN << BUILD_DIR
CLOBBER << OUTPUT_DIR

directory BUILD_DIR
directory OUTPUT_DIR

STATIC_OUTPUT_FILES.each do |e|
  src = e.pathmap("%{^#{OUTPUT_DIR},#{STATIC_DIR}}p")
  dirp = e.pathmap('%d')
  directory dirp

  file e => [dirp, src] do |t|
    cp src, t.name
  end
end

OUTPUT_FILES.each do |e|
  src = e.pathmap("%{^#{OUTPUT_DIR},#{INPUT_DIR}}d.md")
  dirp = e.pathmap('%d')
  directory dirp

  file e => [dirp, src] do |t|
    require 'tilt/erb'
    require 'tilt/kramdown'
    require 'front_matter_parser'

    p t.name
    p src

    parsed = FrontMatterParser::Parser.parse_file(src)
    rendered_html = Kramdown::Document.new(parsed.content).to_html
    File.write(t.name, rendered_html)
  end
end

file RSS_FILE => OUTPUT_FILES do |t|
  require 'rss'
  require 'front_matter_parser'

  rendered_rss = RSS::Maker.make('atom') do |maker|
    maker.channel.author = MAIN_SITE_AUTHOR
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "#{BASE_URL}/index.xml"
    maker.channel.title = SITE_TITLE

    INPUT_FILES.each do |e|
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

  p t.name
  puts rendered_rss
  p t.name
  File.write(t.name, rendered_rss)
end

desc 'Copy static files'
multitask copy_static: STATIC_OUTPUT_FILES

desc 'build output files'
multitask multi_build: OUTPUT_FILES

desc 'Create RSS/Atom feed'
task generate_rss: OUTPUT_DIR do
end

desc 'build site'
multitask build_site: [:multi_build, :copy_static, RSS_FILE]

desc 'Clobber and then build site'
task rebuild: [:clobber, :build_site] # rubocop:disable Style/SymbolArray

desc 'Install dependencies via bundler'
task :install_deps do
  sh 'bundle install'
end

desc 'build site'
task default: [:build_site]
