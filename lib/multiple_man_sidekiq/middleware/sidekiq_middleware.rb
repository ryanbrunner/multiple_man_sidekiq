module MultipleMan
  class SidekiqMiddleware 
    def call(worker, job, queue)
      establish_channel if is_middleman_job?
      yield
    ensure
      close_channel if is_middleman_job?
    end

    def establish_channel
      Thread.local[:multiple_man_connection] = MultipleMan::Connection.new
    end

    def close_channel
      connection = Thread.local[:multiple_man_connection]
      connection.close_channel if connection && connection.open_channel?
    end

    def is_middleman_job?
      worker.kind_of? MultipleMan::ModelPublisherJob
    end
  end
end