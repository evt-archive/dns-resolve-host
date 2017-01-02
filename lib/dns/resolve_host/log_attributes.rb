module DNS
  class ResolveHost
    module LogAttributes
      def self.get(resolve_host, hostname)
        if resolve_host.nameserver_address
          nameserver = "#{resolve_host.nameserver_address}:#{resolve_host.nameserver_port}"
        else
          nameserver = "(system)"
        end

        "Hostname: #{hostname}, Nameserver: #{nameserver}"
      end
    end
  end
end
