# frozen_string_literal: true

require_relative './lib/attribute'
require_relative './application'

class SimpleSerializer
  attr_reader :resource

  class << self
    attr_accessor :attrs_to_serialize
  end

  def initialize(resource, options = {})
    @resource = resource
    @options  = options
  end

  def as_json
    serializable_hash
  end

  def self.attributes(*attrs_list)
    self.attrs_to_serialize = {} if attrs_to_serialize.nil?
    attrs_list.each do |attr_name|
      attrs_to_serialize[attr_name] = Attribute.new(method: attr_name) # , :block)
    end
  end

  # def associations()
  # end

  def serializable_hash
    collection? ? hashlize_for_collection.each(&:deep_stringify_keys) : hashlize_for_one_record.deep_stringify_keys
  end

  def hashlize_for_collection
    resource.map do |record|
      self.class.attrs_to_serialize.transform_values do |attribute|
        attribute.serialize(record)
      end
    end
  end

  def hashlize_for_one_record
    self.class.attrs_to_serialize.transform_values do |attribute|
      attribute.serialize(resource)
    end
  end

  def collection?
    resource.respond_to?(:size) && !resource.respond_to?(:each_pair)
  end
end
