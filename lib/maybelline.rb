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

    def method_missing(method, *args)
      result = @__object__.send(method, *args)

      ::Object.new.send :throw, :nothing if result.nil?

      Maybe.new(result)
    end
  end
end

include Maybelline
