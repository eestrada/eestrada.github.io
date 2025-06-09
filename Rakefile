# frozen_string_literal: true

require 'rake/clean'
# require 'tilt/erb'
# require 'tilt/kramdown'

# Change these constants to pull from elsewhere

# Where your markdown files live.
INPUT_DIR = 'content'

# Where images, CSS, and other static files live.
STATIC_DIR = 'static'

# For intermediate build files.
BUILD_DIR = 'build'

# Where final output goes.
OUTPUT_DIR = 'docs'

INPUT_FILES = FileList["#{INPUT_DIR}/*.md"]
BUILD_FILES = INPUT_FILES.pathmap("%{#{INPUT_DIR},#{BUILD_DIR}}X/index.html")
OUTPUT_FILES = INPUT_FILES.pathmap("%{#{INPUT_DIR},#{OUTPUT_DIR}}X/index.html")
STATIC_FILES = FileList["#{STATIC_DIR}/*"]

CLEAN << BUILD_DIR
CLOBBER << OUTPUT_DIR

directory BUILD_DIR
directory OUTPUT_DIR

multitask multi_render: OUTPUT_FILES
multitask multi_cp: STATIC_FILES

rule(%r{^input/.*\.(?!md)$}) do |t|
  p "hello: #{t.name}"
end

desc 'Copy static files'
task copy_static: OUTPUT_DIR do
end

desc 'Create RSS/Atom feed'
task generate_rss: OUTPUT_DIR do
end

desc 'build site'
task build_site: [BUILD_DIR, OUTPUT_DIR, OUTPUT_FILES, STATIC_FILES]

desc 'Clean and then build site'
task rebuild: [:clean, :build_site] # rubocop:disable Style/SymbolArray

desc 'Install dependencies via bundler'
task :install_deps do
  sh 'bundle install'
end

desc 'build site'
task default: [:build_site]
