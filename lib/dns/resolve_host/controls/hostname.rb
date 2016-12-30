module DNS
  class ResolveHost
    module Controls
      module Hostname
        def self.example(prefix=nil)
          prefix ||= "some-hostname"

          "#{prefix}.example"
        end
      end
    end
  end
end
