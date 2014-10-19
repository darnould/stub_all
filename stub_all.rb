module Kernel
  @@to_stub = []

  alias_method :original_require, :require

  module StubMe
    # Should generally not be rescued, as StandardError would be.
    class MethodNotStubbed < Exception; end

    def self.method_missing(name, *args, &block)
      raise MethodNotStubbed, "#{name} has not been stubbed."
    end
  end

  def require(path)
    previous_constants = constants
    ret = original_require path
    new_constants = constants - previous_constants

    @@to_stub = (@@to_stub + new_constants).uniq

    ret
  end

  def stub_all
    @@to_stub.each do |constant|
      no_warnings do
        Object.const_set(constant, StubMe)
      end
    end
  end

  private

  def constants
    Object.constants
  end

  def no_warnings
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    ret = yield
    $VERBOSE = original_verbosity

    ret
  end
end

