$: << 'lib'
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'boilerplate/version'

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "DESCRIPTION"
  s.name = 'boilerplate'
  s.version = Boilerplate::VERSION
  s.author = 'AUTHOR'
  s.email = 'EMAIL'
  s.homepage = 'HOMEPAGE'

  # s.requirements << 'rake'
  s.require_path = 'lib'
  s.autorequire = 'rake'
  s.files = File.read("Manifest").split
  s.executables = s.files.grep(/bin/) { |f| File.basename(f) }
  s.description = <<EOF
YOUR DESCRIPTION HERE
EOF
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
  t.verbose = false
end

task :default=>:test

namespace :gem do
  desc "Create the gemspec file"
  task :spec do
    File.open("boilerplate.gemspec", "w") do |file|
      file.puts spec.to_ruby
    end
  end
end

desc 'Clean up'
task :clean => :clobber_package do
  %w(diff diff email ri *.gem **/*~ .DS_Store).each do |pattern|
    files = Dir[pattern]
    rm_rf files unless files.empty?
  end
end

namespace :manifest do
  desc "Verify the manifest"
  task :check => :clean do
    f = "Manifest.tmp"
    require 'find'
    files = []
    Find.find '.' do |path|
      next unless File.file? path
      next if path =~ /\.git|tmp$|\.DS_Store/
      files << path[2..-1]
    end
    files = files.sort.join "\n"
    File.open f, 'w' do |fp| fp.puts files end
    system "diff -du Manifest #{f}"
    rm f
  end

  desc "Create the manifest"
  task :create => :clean do
    f = "Manifest"
    require 'find'
    files = []
    Find.find '.' do |path|
      next unless File.file? path
      next if path =~ /\.git|tmp$|\.DS_Store/
      files << path[2..-1]
    end
    files = files.sort.join "\n"
    File.open f, 'w' do |fp| fp.puts files end
  end
end
