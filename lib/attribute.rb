# frozen_string_literal: true

class Attribute
  attr_reader :method, :conditional_proc

  def initialize(method:, options: {})
    @method = method
    @conditional_proc = options[:if]
  end

  def serialize(record)
    # Check if proc condition is met
    record[method]
  end
end
