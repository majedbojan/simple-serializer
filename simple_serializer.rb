# frozen_string_literal: true

require_relative './lib/attribute'
require_relative './lib/association'
require_relative './application'

class SimpleSerializer
  attr_reader :resource, :object

  class << self
    attr_accessor :attrs_to_serialize, :associations_to_serialize
  end

  def initialize(resource, options = {})
    @resource = resource
    @options  = options
    @object = resource unless resource.is_a?(Array)
  end

  def as_json
    collection? ? hashlize_for_collection.map(&:deep_stringify_keys) : hashlize_for_one_record.deep_stringify_keys
  end

  def hashlize_for_collection
    resource.map do |record|
      @object = record
      attribute_serialization(record).merge(association_serialization(record))
    end
  end

  def hashlize_for_one_record
    attribute_serialization.merge(association_serialization)
  end

  def collection?
    resource.respond_to?(:size) && !resource.respond_to?(:each_pair)
  end

  def attribute_serialization(record = nil)
    record ||= resource
    self.class.attrs_to_serialize.transform_values do |attribute|
      if respond_to?(attribute.method)
        public_send(attribute.method)
      else
        attribute.serialize(record)
      end
    end
  end

  def association_serialization(record = nil)
    return {} if self.class.associations_to_serialize.nil?

    record ||= resource

    self.class.associations_to_serialize.transform_values do |association|
      association.serialize(record)
    end
  end

  def self.attributes(*attrs_list)
    self.attrs_to_serialize = {} if attrs_to_serialize.nil?
    attrs_list.each do |attr_name|
      attrs_to_serialize[attr_name] = Attribute.new(method: attr_name)
    end
  end

  # Associations
  # rubocop:disable Naming/PredicateName
  def self.has_many(association_name, options = {}, &block)
    association = create_association(association_name, options, block)
    add_association(association)
  end

  def self.has_one(association_name, options = {}, &block)
    association = create_association(association_name, options, block)
    add_association(association)
  end

  def self.belongs_to(association_name, options = {}, &block)
    association = create_association(association_name, options, block)
    add_association(association)
  end
  # rubocop:enable Naming/PredicateName

  def self.create_association(name, options, _block)
    Association.new(name: name, options: options)
  end

  def self.add_association(association)
    self.associations_to_serialize = {} if associations_to_serialize.nil?
    associations_to_serialize[association.key] = association
  end
end
