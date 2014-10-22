module MultipleMan
  class AsyncModelPublisher < ModelPublisher

    def publish(records, operation=:create)
      return unless MultipleMan.configuration.enabled

      if records.respond_to?(:pluck)
        return unless records.any?
        ids = records.pluck(:id)
        klass = records.first.class.name
      else
        return if records.nil?
        ids = [records.id]
        klass = records.class.name
      end

      # Split jobs into parts so sidekiq doesn't need to deal with enormous seed jobs.
      ids.each_slice(1000) do |ids|
        queue = MultipleMan.configuration.sidekiq_queue[operation.to_sym] || 'default'

        Sidekiq::Client.push({
          'class' => ModelPublisherJob,
          'queue' => queue,
          'args'  => [ klass, ids, options, operation ]
        })
      end
    end

  end

  class ModelPublisherJob
    include Sidekiq::Worker

    def perform(record_type, ids, options, operation)
      records = Kernel.const_get(record_type).where(id: ids)
      ModelPublisher.new(options).publish(records, operation)
    end
  end
end
