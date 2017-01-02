require 'dns/resolve_host/controls/ip_address'
require 'dns/resolve_host/controls/hostname'

begin
  require 'rubydns'
  require 'dns/resolve_host/controls/server'
rescue LoadError
  require 'pathname'

  log_subject = Pathname.new(__FILE__).relative_path_from(Pathname.new(Dir.pwd))
  logger = DNS::ResolveHost::Log.get log_subject.to_s

  logger.warn <<~TEXT
  rubydns is not present in the load path. As a result, the control server was not loaded. If the control server is needed, add `rubydns' to the current project.
  TEXT
end
