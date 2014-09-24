require 'active_support/core_ext'

module MultipleMan
  module AsyncPublisher
    include MultipleMan::Publisher
    def ASyncPublisher.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      
      def publish(options = {})
        self.multiple_man_publisher = AsyncModelPublisher.build(options)
      end
    end
  end
end