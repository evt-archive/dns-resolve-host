module DNS
  class ResolveHost
    module StaticResolver
      def self.get(hosts_file=nil)
        logger.trace { "Constructing static resolver (HostsFile: #{hosts_file.inspect})" }

        if hosts_file.nil?
          hosts_file = Resolv::Hosts::DefaultFileName
        elsif !File.exist?(hosts_file)
          File.open(hosts_file) { }
        end

        static_resolver = Resolv::Hosts.new hosts_file

        logger.trace { "Static resolver constructed (HostsFile: #{hosts_file})" }

        static_resolver
      end

      def self.configure(receiver, hosts_file=nil, attr_name: nil)
        attr_name ||= :static_resolver

        instance = get hosts_file
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def self.logger
        @logger ||= Log.get self
      end

      module Assertions
        def file?(file)
          @filename == file
        end
      end
    end
  end
end
