# frozen_string_literal: true

require 'spec_helper'

describe Api::V1::ReservationSerializer do
  subject { serializer.as_json }
  let(:reservation) do
    Reservation.new(
      id:         '1',
      status:     'confirmed',
      covers:     2,
      walk_in:    false,
      start_time: Time.now,
      duration:   30,
      notes:      '',
      guest:      Guest.new(id: '1', first_name: 'John', last_name: 'Doe'),
      restaurant: Restaurant.new(id: '1', name: 'Restaurant 1', address: '123 Main St'),
      tables:     [Table.new(id: '1', number: 1, max_covers: 4)]
    )
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
      data = API::V1::RestaurantSerializer.new(reservation.restaurant).as_json.deep_stringify_keys
      expect(subject['restaurant']).to eq(data)
    end

    it 'returns single guest' do
      data = Api::V1::GuestSerializer.new(reservation.guest).as_json
      expect(subject['guest']).to eq(data)
    end

    it 'returns array of tables' do
      data = reservation.tables.map { API::V1::TableSerializer.new(_1).as_json }
      expect(subject['tables']).to contain_exactly(data)
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
end
