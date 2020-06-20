# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(name, type, *args)
      @validates ||= []
      if name.is_a?(Array)
        name.each { |attr_name| @validates << { variable: attr_name, type: type, args: args[0] } }
      else
        @validates << { variable: name, type: type, args: args[0] }
      end
    end
  end

  module InstanceMethods
    def validate!
      @validates = self.class.instance_variable_get(:@validates)
      @validates.each do |validate|
        value = instance_variable_get("@#{validate[:variable]}")
        name = validate[:variable].capitalize
        send("validate_#{validate[:type]}", value, name, *validate[:args])
      end
    end

    def validate_presence(value, name)
      raise PresenceError, "#{name} can't be blank" if value.to_s.empty? || value.nil?
    end

    def validate_more_than(value, name, conditional_value)
      raise NumberValueError, "#{name} must be more than #{conditional_value}" unless value > conditional_value
    end

    def validate_type(value, name, type_class)
      raise TypeClassError, "#{name} must be an instance of #{type_class} class" unless value.instance_of? type_class
    end
  end
end
