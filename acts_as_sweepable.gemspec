# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_sweepable}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.cert_chain = ["/home/mencio/.cert_keys/gem-public_cert.pem"]
  s.date = %q{2011-04-09}
  s.description = %q{Adds a class method called sweep to ActiveRecord - used to remove old elements}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = ["README.md", "lib/acts_as_sweepable.rb"]
  s.files = ["MIT-LICENSE", "README.md", "Rakefile", "init.rb", "lib/acts_as_sweepable.rb", "spec/acts_as_sweepable_spec.rb", "spec/spec_helper.rb", "Manifest", "acts_as_sweepable.gemspec"]
  s.homepage = %q{https://github.com/mensfeld/acts_as_sweepable}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_sweepable", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{acts_as_sweepable}
  s.rubygems_version = %q{1.5.2}
  s.signing_key = %q{/home/mencio/.cert_keys/gem-private_key.pem}
  s.summary = %q{Adds a class method called sweep to ActiveRecord - used to remove old elements}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<active_record>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<active_record>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<active_record>, [">= 0"])
  end
end
