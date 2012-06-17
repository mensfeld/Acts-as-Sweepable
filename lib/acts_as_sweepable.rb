
module Acts
  module AsSweepable

    class InvalidTime < StandardError; end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def sweep(*sources)
        # time_ago = nil, conditions = nil, created_or_updated = true
        options = sources.extract_options!.stringify_keys
        options = options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

        time_ago = options.delete(:time)
        conditions = options.delete(:conditions)
        columns = [options.delete(:columns) || :updated_at].flatten
        remove_method = options.delete(:method) || :destroy_all


        time = case time_ago
          when /^(\d+)m$/ then Time.now - $1.to_i.minute
          when /^(\d+)h$/ then Time.now - $1.to_i.hour
          when /^(\d+)d$/ then Time.now - $1.to_i.day
          else raise(InvalidTime, time_ago)
        end

        statement = []
        columns.each do |column|
          statement << "#{column}  < '#{time.to_s(:db)}'"
        end

        statement = "(#{statement.join(' OR ')})"

        conditions = "AND #{conditions} " if conditions

        # Run on each block of code
        if block_given?
          els = self.where("#{statement} #{conditions}")
          els.find_each {|el| yield el }
        end

        res = self.send(remove_method, "#{statement} #{conditions}")
        case res
          when Integer
            res
          when nil
            0
          when Array
            res.length
        end
      end
    end

  end
end

ActiveRecord::Base.send(:include, Acts::AsSweepable)
