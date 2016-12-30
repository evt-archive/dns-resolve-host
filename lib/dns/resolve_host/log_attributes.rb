module DNS
  class ResolveHost
    module LogAttributes
      def self.get(resolve_host, hostname)
        if resolve_host.nameserver
          nameserver = resolve_host.nameserver.to_a * ':'
        else
          nameserver = "(system)"
        end

        "Hostname: #{hostname}, Nameserver: #{nameserver}"
      end
    end
  end
end
