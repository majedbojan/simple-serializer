# frozen_string_literal: true

require 'spec_helper'

describe Api::V1::GuestSerializer do
  let(:guest) { Guest.new('1', 'John', 'Doe') }
  let(:guests) { [guest, Guest.new('2', 'Jack', 'Doe')] }
  let(:serializer) { described_class.new(guest) }

  subject { serializer.as_json }
  it 'allows attributes to be defined for serialization' do
    expect(subject.keys).to contain_exactly(
      *%w[id first_name last_name]
    )
  end

  describe 'when a collection' do
    subject { described_class.new(guests).as_json }

    it 'returns an array of serialized objects' do
      expect(subject).to be_an_instance_of(Array)
    end

    it 'returns two objects' do
      expect(subject.count).to eq(2)
    end
  end
end
