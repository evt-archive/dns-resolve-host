ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
require 'dns/resolve_host/controls'

require 'test_bench'; TestBench.activate

require 'pp'

Controls = DNS::ResolveHost::Controls

Resolv::Hosts.send :const_set, :Assertions, DNS::ResolveHost::StaticResolver::Assertions
