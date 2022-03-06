# frozen_string_literal: true

class Attribute
  attr_reader :method

  def initialize(method:)
    @method = method
  end

  def serialize(record)
    record.public_send(method)
  end
end

# TODO: Check if proc condition is met
