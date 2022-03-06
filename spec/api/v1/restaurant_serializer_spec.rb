# frozen_string_literal: true

require 'spec_helper'

describe Api::V1::RestaurantSerializer do
  let(:restaurant) { Restaurant.new('1', 'The Aviary', '1313 Mockingbird Lane') }
  let(:restaurants) { [restaurant, Restaurant.new('2', 'Brass Tacks', '1314 Mockingbird Lane')] }
  let(:serializer) { described_class.new(restaurant) }

  subject { serializer.as_json }
  it 'allows attributes to be defined for serialization' do
    expect(subject.keys).to contain_exactly(
      *%w[id name address]
    )
  end

  describe 'when a collection' do
    subject { described_class.new(restaurants).as_json }

    it 'returns an array of serialized objects' do
      expect(subject).to be_an_instance_of(Array)
    end

    it 'returns two objects' do
      expect(subject.count).to eq(2)
    end
  end
end
