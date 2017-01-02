module DNS
  class ResolveHost
    class Settings < ::Settings
      def self.data_source
        if File.exist? 'settings/dns_resolve_host.json'
          'settings/dns_resolve_host.json'
        else
          {}
        end
      end

      def self.instance
        instance ||= build
      end
    end
  end
end
