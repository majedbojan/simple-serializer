# frozen_string_literal: true

class Association
  attr_reader :key, :serializer

  def initialize(name:, options: {})
    @key = name
    @serializer = options[:serializer]
  end

  def serialize(record)
    association = record.public_send(key)
    serializer ? serializer.new(association).as_json : association
  end
end

# TODO: Check if proc condition is met
