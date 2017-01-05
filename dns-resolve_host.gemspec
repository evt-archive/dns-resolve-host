# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-dns-resolve_host'
  s.version = '0.1.0.0'
  s.summary = "Resolve host names to IP addresses"
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/dns-resolve-host'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-configure'
  s.add_runtime_dependency 'evt-settings'

  s.add_development_dependency 'test_bench'
  s.add_development_dependency 'rubydns'
end
