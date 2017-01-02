require 'resolv'

require 'configure'; Configure.activate
require 'settings'; Settings.activate

require 'dns/resolve_host/log'

require 'dns/resolve_host/defaults'
require 'dns/resolve_host/log_attributes'
require 'dns/resolve_host/resolve_host'
require 'dns/resolve_host/resolution_error'
require 'dns/resolve_host/settings'
require 'dns/resolve_host/substitute'
require 'dns/resolve_host/static_resolver'
