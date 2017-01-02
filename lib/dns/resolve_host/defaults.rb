module DNS
  class ResolveHost
    module Defaults
      def self.local_hosts_file
        'settings/hosts'
      end

      def self.port
        53
      end
    end
  end
end
