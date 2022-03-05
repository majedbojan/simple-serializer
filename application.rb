# frozen_string_literal: true

# require_relative '../application'
require_relative './models/guest'
require_relative './models/table'
require_relative './models/restaurant'
require_relative './models/reservation'

require_relative './api/v1/guest_serializer'
require_relative './api/v1/table_serializer'
require_relative './api/v1/reservation_serializer'
require_relative './api/v1/restaurant_serializer'

# This class was
class Hash
  def stringify_keys
    transform_keys(&:to_s)
  end

  def stringify_keys!
    transform_keys!(&:to_s)
  end

  def symbolize_keys
    transform_keys do |key|
      key.to_sym
    rescue StandardError
      key
    end
  end
  alias to_options symbolize_keys

  def symbolize_keys!
    transform_keys! do |key|
      key.to_sym
    rescue StandardError
      key
    end
  end
  alias to_options! symbolize_keys!

  def deep_transform_keys(&block)
    _deep_transform_keys_in_object(self, &block)
  end

  def deep_transform_keys!(&block)
    _deep_transform_keys_in_object!(self, &block)
  end

  def deep_stringify_keys
    deep_transform_keys(&:to_s)
  end

  def deep_stringify_keys!
    deep_transform_keys!(&:to_s)
  end

  def deep_symbolize_keys
    deep_transform_keys do |key|
      key.to_sym
    rescue StandardError
      key
    end
  end

  def deep_symbolize_keys!
    deep_transform_keys! do |key|
      key.to_sym
    rescue StandardError
      key
    end
  end

  private

  # Support methods for deep transforming nested hashes and arrays.
  def _deep_transform_keys_in_object(object, &block)
    case object
    when Hash
      object.each_with_object({}) do |(key, value), result|
        result[yield(key)] = _deep_transform_keys_in_object(value, &block)
      end
    when Array
      object.map { |e| _deep_transform_keys_in_object(e, &block) }
    else
      object
    end
  end

  def _deep_transform_keys_in_object!(object, &block)
    case object
    when Hash
      object.each_key do |key|
        value = object.delete(key)
        object[yield(key)] = _deep_transform_keys_in_object!(value, &block)
      end
      object
    when Array
      object.map! { |e| _deep_transform_keys_in_object!(e, &block) }
    else
      object
    end
  end
end

# Reservation = Struct.new(:id, :status, :covers, :walk_in, :start_time, :duration, :notes, :guest, :restaurant, :tables) do
#   def id
#     @id.presence || SecureRandom.uuid
#   end

#   def created_at
#     Time.current
#   end

#   def updated_at
#     Time.current
#   end
# end

# Guest = Struct.new(:id, :first_name, :last_name) do
#   def id
#     @id.presence || SecureRandom.uuid
#   end

#   def created_at
#     Time.current
#   end

#   def updated_at
#     Time.current
#   end
# end

# Table = Struct.new(:id, :number, :max_covers) do
#   def id
#     @id.presence || SecureRandom.uuid
#   end

#   def created_at
#     Time.current
#   end

#   def updated_at
#     Time.current
#   end
# end

# Restaurant = Struct.new(:id, :name, :address) do
#   def id
#     @id.presence || SecureRandom.uuid
#   end

#   def created_at
#     Time.current
#   end

#   def updated_at
#     Time.current
#   end
# end
