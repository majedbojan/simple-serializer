# frozen_string_literal: true

require 'spec_helper'

describe Api::V1::ReservationSerializer do
  subject { serializer.as_json }
  let(:reservation) do
    Reservation.new('1', 'not_confirmed', 2, false, Time.now, 5400, nil,
                    Guest.new('1', 'John', 'Doe'),
                    Restaurant.new('1', 'Restaurant 1', '123 Main St'),
                    [Table.new('1', 1, 4)])
  end

  let(:reservations) do
    [reservation, Reservation.new('2', 'confirmed', 2, false, Time.now, 5400, nil,
                                  Guest.new('2', 'Jack2', 'Doew'),
                                  Restaurant.new('2', 'Restaurant 2', '123 Main St'),
                                  [Table.new('2', 1, 4)])]
  end

  let(:serializer) { described_class.new(reservation) }

  it 'allows attributes to be defined for serialization' do
    expect(subject.keys).to contain_exactly(
      *%w[
        id
        status
        covers
        walk_in
        start_time
        duration
        notes
        created_at
        updated_at
        restaurant
        guest
        tables
      ]
    )
  end

  describe 'relationships' do
    it 'returns single restaurant' do
      data = Api::V1::RestaurantSerializer.new(reservation.restaurant).as_json.deep_stringify_keys
      expect(subject['restaurant']).to eq(data)
    end

    it 'returns single guest' do
      data = Api::V1::GuestSerializer.new(reservation.guest).as_json
      expect(subject['guest']).to eq(data)
    end

    it 'returns array of tables' do
      data = Api::V1::TableSerializer.new(reservation.tables).as_json
      expect(subject['tables']).to contain_exactly(*data)
      # expect(subject['tables']).to eq(data)
    end
  end

  describe 'notes' do
    it 'is nil if an empty string' do
      reservation.notes = ''
      expect(subject['notes']).to eq(nil)
    end
  end

  describe '#as_json' do
    it 'returns correct payload' do
      expect(subject.except('guest', 'restaurant', 'tables')).to eq(
        'id'         => reservation.id,
        'status'     => 'not_confirmed',
        'covers'     => 2,
        'walk_in'    => false,
        'start_time' => reservation.start_time.iso8601,
        'duration'   => 5400,
        'notes'      => nil,
        'created_at' => reservation.created_at.iso8601,
        'updated_at' => reservation.updated_at.iso8601
      )
    end
  end

  describe '#collections' do
    subject { described_class.new(reservations).as_json }

    it 'returns an array of serialized objects' do
      expect(subject).to be_an_instance_of(Array)
    end

    it 'returns two objects' do
      expect(subject.count).to eq(2)
    end
  end
end
