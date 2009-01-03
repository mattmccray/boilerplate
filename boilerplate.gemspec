# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{boilerplate}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["AUTHOR"]
  s.autorequire = %q{rake}
  s.date = %q{2009-01-03}
  s.default_executable = %q{boilerplate}
  s.description = %q{YOUR DESCRIPTION HERE}
  s.email = %q{EMAIL}
  s.executables = ["boilerplate"]
  s.files = ["Changes", "Manifest", "Rakefile", "Readme.markdown", "bin/boilerplate", "boilerplate.gemspec", "lib/boilerplate.rb", "lib/boilerplate/cli.rb", "lib/boilerplate/version.rb", "test/helper.rb", "test/test_boilerplate.rb"]
  s.homepage = %q{HOMEPAGE}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{DESCRIPTION}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
