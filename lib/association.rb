# frozen_string_literal: true

class Association
  attr_reader :key, :serializer, :conditional_proc

  def initialize(name:, options: {})
    @key = name
    @conditional_proc = options[:if]
    @serializer = options[:serializer]
  end

  def serialize(record)
    # TODO: Check if proc condition is met
    association = record.public_send(key)
    serializer ? serializer.new(association).as_json : association
  end
end
