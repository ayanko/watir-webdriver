# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ayanko-watir-webdriver"
  s.version = "0.1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jari Bakken"]
  s.date = Time.now.strftime("%F")
  s.description = %q{WebDriver-backed Watir}
  s.email = %q{jari.bakken@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  
  s.files = `git ls-files`.split("\n")

  s.homepage = %q{http://github.com/jarib/watir-webdriver}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Watir on WebDriver}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<selenium-webdriver>, ["= 0.0.29"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6"])
      s.add_development_dependency(%q<webidl>, [">= 0.0.6"])
      s.add_development_dependency(%q<sinatra>, ["~> 1.0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, ["~> 2.3.5"])
    else
      s.add_dependency(%q<selenium-webdriver>, ["= 0.0.29"])
      s.add_dependency(%q<rspec>, ["~> 2.0.0"])
      s.add_dependency(%q<yard>, ["~> 0.6"])
      s.add_dependency(%q<webidl>, [">= 0.0.6"])
      s.add_dependency(%q<sinatra>, ["~> 1.0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
    end
  else
    s.add_dependency(%q<selenium-webdriver>, ["= 0.0.29"])
    s.add_dependency(%q<rspec>, ["~> 2.0.0"])
    s.add_dependency(%q<yard>, ["~> 0.6"])
    s.add_dependency(%q<webidl>, [">= 0.0.6"])
    s.add_dependency(%q<sinatra>, ["~> 1.0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<activesupport>, ["~> 2.3.5"])
  end
end

