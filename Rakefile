require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "watir-webdriver"
    gem.summary     = %Q{Watir on WebDriver}
    gem.description = %Q{WebDriver-backed Watir}
    gem.email       = "jari.bakken@gmail.com"
    gem.homepage    = "http://github.com/jarib/watir-webdriver"
    gem.authors     = ["Jari Bakken"]

    gem.add_dependency "selenium-webdriver", '0.0.29'

    gem.add_development_dependency "rspec", "~> 2.0.0"
    gem.add_development_dependency "yard", "~> 0.6"
    gem.add_development_dependency "webidl", ">= 0.0.6"
    gem.add_development_dependency "sinatra", "~> 1.0"
    gem.add_development_dependency "nokogiri"
    gem.add_development_dependency "activesupport", "~> 2.3.5" # for pluralization during code generation
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern   = 'spec/**/*_spec.rb'
end

namespace :spec do
  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.ruby_opts = "-I lib:spec"
    spec.pattern   = 'spec/**/*_spec.rb'
    spec.rcov      = true
    spec.rcov_opts = %w[--exclude spec,ruby-debug,/Library/Ruby,.gem --include lib/watir-webdriver]
  end

  desc 'Run specs for CI'
  RSpec::Core::RakeTask.new(:ci) do |spec|
    spec.ruby_opts  = "-I lib:spec"
    spec.pattern    = 'spec/**/*_spec.rb'
    spec.rspec_opts = ["--format", "html:results/#{RUBY_PLATFORM}/#{ENV['WATIR_WEBDRIVER_BROWSER'] || 'firefox'}/spec-results.html",
                      "--format", "progress",
                      "--backtrace"]
    spec.rcov       = true
    spec.rcov_opts  = %w[--exclude spec,ruby-debug,/Library/Ruby,.gem --include lib/watir-webdriver]
  end
end

task :spec => :check_dependencies

task :lib do
  $LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
end

namespace :html5 do
  SPEC_URI  = "http://www.whatwg.org/specs/web-apps/current-work/"
  SPEC_PATH = "support/html5.html"

  task :html_lib => :lib do
    require 'watir-webdriver/html'
  end

  desc "Download the HTML5 spec from #{SPEC_URI}"
  task :download do
    require "open-uri"
    mv SPEC_PATH, "#{SPEC_PATH}.old" if File.exist?(SPEC_PATH)
    downloaded_bytes = 0

    File.open(SPEC_PATH, "w") do |io|
      io << "<!--  downloaded from #{SPEC_URI} on #{Time.now} -->\n"
      io << data = open(SPEC_URI).read
      downloaded_bytes = data.bytesize
    end

    puts "#{SPEC_URI} => #{SPEC_PATH} (#{downloaded_bytes} bytes)"
  end

  desc "Print IDL parts from #{SPEC_URI}"
  task :print => :html_lib do
    extractor = Watir::HTML::SpecExtractor.new(SPEC_PATH)

    extractor.process.each do |tag_name, interface_definitions|
      puts "#{tag_name.ljust(10)} => #{interface_definitions.map { |e| e.name }}"
    end

    extractor.print_hierarchy

    unless extractor.errors.empty?
      puts "\n\n<======================= ERRORS =======================>\n\n"
      puts extractor.errors.join("\n" + "="*80 + "\n")
    end
  end

  desc 'Re-enerate the base Watir element classes from the spec '
  task :generate => :html_lib do
    old_file = "lib/watir-webdriver/elements/generated.rb"
    generator = Watir::HTML::Generator.new

    File.open("#{old_file}.new", "w") do |file|
      generator.generate(SPEC_PATH, file)
    end

    if File.exist?(old_file)
      system "diff -Naut #{old_file} #{old_file}.new | less"
    end
  end

  desc 'Move generated.rb.new to generated.rb'
  task :overwrite do
    file = "lib/watir-webdriver/elements/generated.rb"
    mv "#{file}.new", file
  end

  desc 'download spec -> generate -> generated.rb'
  task :update => [:download, :generate, :overwrite]
end # html5

task :default => :spec

begin
  require 'yard'
  Rake::Task[:lib].invoke
  require "yard/handlers/watir"
  YARD::Rake::YardocTask.new do |task|
    task.options = %w[--debug] # this is pretty slow, so nice with some output
  end
rescue LoadError
  task :yard do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

load "spec/watirspec/watirspec.rake" if File.exist?("spec/watirspec/watirspec.rake")
