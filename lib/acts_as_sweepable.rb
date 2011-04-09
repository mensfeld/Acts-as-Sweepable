
module Acts
  module AsSweepable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def sweep(time_ago = nil, conditions = nil, created_or_updated = true)
        time = case time_ago
          when /^(\d+)m$/ then Time.now - $1.to_i.minute
          when /^(\d+)h$/ then Time.now - $1.to_i.hour
          when /^(\d+)d$/ then Time.now - $1.to_i.day
          else Time.now - 1.hour
        end

        statement = "updated_at < '#{time.to_s(:db)}'"

        if created_or_updated
          statement += " OR created_at < '#{time.to_s(:db)}')"
          statement = '('+statement
        end

        conditions = "AND #{conditions} " if conditions

        els = self.where("#{statement} #{conditions}")

        # Run on each block of code
        els.each {|el| yield el } if block_given?

        self.delete_all "#{statement} #{conditions}"
      end
    end
    
  end
end

ActiveRecord::Base.send(:include, Acts::AsSweepable)

