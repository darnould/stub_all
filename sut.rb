require "faraday"

class SUT
  attr_reader :dependency

  def initialize
    @dependency = Faraday.new
  end
end
