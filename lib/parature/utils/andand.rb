class Object

  # Returns nil if its receiver is nil, regardless of whether nil actually handles the
  # actual method ot what it might return.
  #
  #    'foo'.andand.size => 3
  #    nil.andand.size => nil
  #    'foo'.andand { |s| s << 'bar' } => 'foobar'
  #    nil.andand { |s| s << 'bar' } => nil
  def andand(p = nil)
    if self
      if block_given?
        yield(self)
      elsif p
        p.to_proc.call(self)
      else
        self
      end
    else
      if block_given? or p
        self
      else
        MockReturningMe.new(self)
      end
    end
  end

  # A proxy that returns its target without invoking the method you invoke.
  class MockReturningMe < BasicObject
    def initialize(me)
      super()
      @me = me
    end
    def method_missing(*args)
      @me
    end
  end

end
