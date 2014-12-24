# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','tureng','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'tureng-cli'
  s.description = 'A command line program using tureng.com to english-turkish translation.'
  s.version = Tureng::VERSION
  s.author = 'Yusuf YALIM'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = []
  s.rdoc_options << '--title' << 'tureng' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'tureng'
  s.add_development_dependency('rake', '10.3.2')
  s.add_development_dependency('rdoc', '4.1.2')
  s.add_development_dependency('aruba', '0.6.1')
  s.add_runtime_dependency('nokogiri', '1.6.4.1')
  s.add_runtime_dependency('text-table', '1.2.3')
  s.add_runtime_dependency('gli','2.12.2')
  s.license = 'MIT'
end
