require "maybelline/version"

module Maybelline
  def maybe
    Maybe(self, &Proc.new)
  end

  def Maybe(object)
    catch :nothing do
      result = yield Maybe.new(object)

      result.respond_to?(:__object__) ? result.__object__ : result
    end
  end

  class Maybe < BasicObject
    attr_reader :__object__

    def initialize(object)
      @__object__ = object

      ::Object.new.send :throw, :nothing if @__object__.nil?      
    end

    def ==(other)
      @__object__ == other
    end

    def equal?(other)
      @__object__.equal?(other)
    end

    def instance_eval(*args)
      if block_given?
        @__object__.instance_eval(*args, &Proc.new)
      else
        @__object__.instance_eval(*args)
      end
    end

    def instance_exec(*args)
      if block_given?
        @__object__.instance_exec(*args, &Proc.new)
      else
        @__object__.instance_exec(*args)
      end
    end

    def method_missing(method, *args)
      result = if block_given?
                 @__object__.__send__(method, *args, &Proc.new)
               else
                 @__object__.__send__(method, *args)
               end

      ::Object.new.send :throw, :nothing if result.nil?

      Maybe.new(result)
    end
  end
end

include Maybelline
