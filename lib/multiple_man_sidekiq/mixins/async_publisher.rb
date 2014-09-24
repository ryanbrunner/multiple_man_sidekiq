require 'active_support/core_ext'

module MultipleMan
  module AsyncPublisher
    
    def AsyncPublisher.included(base)
      base.include(MultipleMan::Publisher)
      base.extend(ClassMethods)
    end

    module ClassMethods
      
      def publish(options = {})
        self.multiple_man_publisher = AsyncModelPublisher.new(options)
      end
    end
  end
end