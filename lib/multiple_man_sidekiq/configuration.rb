module MultipleManSidekiq
  class Configuration

    def initialize
      self.sidekiq_queue = {}
    end

    attr_reader :sidekiq_queue

  private
    attr_writer :sidekiq_queue
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end