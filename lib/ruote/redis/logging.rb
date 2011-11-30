require 'logger'

module Ruote
  module Redis
    module Logging

      def self.included(recipient)
        recipient.class_eval do
          include InstanceMethods
        end
      end
    end

    module InstanceMethods
      def error(message)
        with_logger do |logger|
          logger.error "#" * 50
          logger.error "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}] #{message}"
        end
      end

    protected

      def with_logger
        logger = ::Logger.new("/tmp/ruote-redis.log")
        yield logger
        logger.close
      end
    end
  end
end
