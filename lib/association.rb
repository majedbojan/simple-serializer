# frozen_string_literal: true

class Association
  attr_reader :key, :serializer, :conditional_proc

  def initialize(name:, options: {})
    # @method = method
    @key = name
    @conditional_proc = options[:if]
    @serializer = options[:serializer]
  end

  def serialize(record)
    # Check if proc condition is met
    # Check for updated and created at methods

    association = record.public_send(key)
    serializer ? serializer.new(association).as_json : association
  end
end
