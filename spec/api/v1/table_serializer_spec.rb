# frozen_string_literal: true

require 'spec_helper'

describe Api::V1::TableSerializer do
  let(:table) { Table.new('1', 5, 10) }
  let(:tables) { [table, Table.new('2', 2, 12)] }
  let(:serializer) { described_class.new(table) }

  subject { serializer.as_json }
  it 'allows attributes to be defined for serialization' do
    expect(subject.keys).to contain_exactly(
      *%w[id number max_covers]
    )
  end

  describe 'when a collection' do
    subject { described_class.new(tables).as_json }

    it 'returns an array of serialized objects' do
      expect(subject).to be_an_instance_of(Array)
    end

    it 'returns two objects' do
      expect(subject.count).to eq(2)
    end
  end
end
