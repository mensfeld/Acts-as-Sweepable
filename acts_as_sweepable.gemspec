# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "acts_as_sweepable"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.date = "2012-06-17"
  s.description = "Adds a class method called sweep to ActiveRecord - used to remove old elements"
  s.email = "maciej@mensfeld.pl"
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/acts_as_sweepable.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "Manifest", "README.md", "Rakefile", "init.rb", "lib/acts_as_sweepable.rb", "spec/acts_as_sweepable_spec.rb", "spec/spec_helper.rb", "acts_as_sweepable.gemspec"]
  s.homepage = "https://github.com/mensfeld/Acts-as-Sweepable"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_sweepable", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "acts_as_sweepable"
  s.rubygems_version = "1.8.10"
  s.summary = "Adds a class method called sweep to ActiveRecord - used to remove old elements"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<active_record>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<active_record>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<active_record>, [">= 0"])
  end
end
