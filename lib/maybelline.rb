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
      @__object__.instance_eval(*args)
    end

    def instance_exec(*args)
      @__object__.instance_exec(*args)
    end

    def method_missing(method, *args)
      result = @__object__.__send__(method, *args)

      Maybe.new(result)
    end
  end
end

include Maybelline
