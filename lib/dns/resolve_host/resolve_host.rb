module DNS
  class ResolveHost
    include Log::Dependency

    configure :resolve_host

    attr_accessor :nameserver

    def self.call(hostname, &block)
      instance = new
      instance.()
    end

    def call(hostname, &block)
      if nameserver
        options = { :nameserver_port => [nameserver.to_a] }
      else
        options = nil
      end

      logger.trace { "Resolving host (#{LogAttributes.get self, hostname})" }

      Resolv::DNS.open options do |dns|
        block.(dns) if block

        addresses = dns.getaddresses hostname

        addresses.map! &:to_s

        if addresses.empty?
          logger.warn { "Could not resolve host (#{LogAttributes.get self, hostname})" }
        else
          logger.info { "Resolved host (#{LogAttributes.get self, hostname}, Address#{'es' unless addresses.count == 1}: #{addresses * ', '})" }
        end

        return addresses
      end
    end

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
