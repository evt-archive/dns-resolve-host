module DNS
  class ResolveHost
    include Log::Dependency

    configure :resolve_host

    attr_accessor :nameserver_address
    attr_writer :nameserver_port

    dependency :hosts_resolver, Resolv::Hosts

    def self.build(address: nil, port: nil, hosts_file: nil)
      if address.nil? and not port.nil?
        raise ArgumentError, "Cannot specify port without address"
      end

      instance = new

      StaticResolver.configure instance, hosts_file, attr_name: :hosts_resolver

      instance.nameserver_address = address if address
      instance.nameserver_port = port if port

      instance
    end

    def self.call(hostname, &block)
      instance = new
      instance.(hostname, &block)
    end

    def call(hostname, &block)
      logger.trace { "Resolving host (#{LogAttributes.get self, hostname})" }

      Resolv::DNS.open dns_resolver_options do |dns_resolver|
        resolver = Resolv.new [hosts_resolver, dns_resolver]

        block.(dns_resolver) if block

        addresses = resolver.getaddresses hostname

        addresses.map! &:to_s

        if addresses.empty?
          error_message = "Could not resolve host (#{LogAttributes.get self, hostname})"
          logger.error { error_message }
          raise ResolutionError, error_message
        end

        logger.info { "Resolved host (#{LogAttributes.get self, hostname}, Address#{'es' unless addresses.count == 1}: #{addresses * ', '})" }

        return addresses
      end
    end

    def dns_resolver_options
      if nameserver_address
        { :nameserver_port => [nameserver] }
      else
        # Resolv::DNS.new expects the options argument to be *nil* when the
        # system nameservers are meant to be used [Nathan Ladd, Mon 2 Jan 2017]
        nil
      end
    end

    def nameserver
      [nameserver_address, nameserver_port]
    end

    def nameserver_port
      @nameserver_port ||= Defaults.port
    end
  end
end
