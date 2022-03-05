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
  # let(:serializer) { described_class.new(reservation) }

  # it 'allows attributes to be defined for serialization' do
  #   expect(subject.keys).to contain_exactly(
  #     *%w[
  #       id
  #       status
  #       covers
  #       walk_in
  #       start_time
  #       duration
  #       notes
  #       created_at
  #       updated_at
  #       restaurant
  #       guest
  #       tables
  #     ]
  #   )
  # end

  describe 'relationships' do
    # it 'returns single restaurant' do
    #   data = API::V1::RestaurantSerializer.new(reservation.restaurant).as_json.deep_stringify_keys
    #   expect(subject['restaurant']).to eq(data)
    # end

    it 'returns single guest' do
      # data = Api::V1::GuestSerializer.new(Guest.new(1, 'John', 'Doe')).as_json
      # expect({ id: 1, first_name: 'John' , last_name: 'Doe'}).to eq(data)

      data = Api::V1::GuestSerializer.new(reservation.guest).as_json
      expect(subject['guest']).to eq(data)
    end

    # it 'returns array of tables' do
    #   data = reservation.tables.map { API::V1::TableSerializer.new(_1).as_json }
    #   expect(subject['tables']).to contain_exactly(data)
    # end
  end

  # describe 'notes' do
  #   it 'is nil if an empty string' do
  #     reservation.notes = ''
  #     expect(subject['notes']).to eq(nil)
  #   end
  # end

  # describe '#as_json' do
  #   it 'returns correct payload' do
  #     expect(subject.except('guest', 'restaurant', 'tables')).to eq(
  #       'id'         => reservation.id,
  #       'status'     => 'not_confirmed',
  #       'covers'     => 2,
  #       'walk_in'    => false,
  #       'start_time' => reservation.start_time.iso8601,
  #       'duration'   => 5400,
  #       'notes'      => nil,
  #       'created_at' => reservation.created_at.iso8601,
  #       'updated_at' => reservation.updated_at.iso8601
  #     )
  #   end
  # end
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

# class API::V1::RestaurantSerializer < SimpleSerializer
#   attributes :id,
#              :name,
#              :address
#   def address
#     object.address.presence
#   end
# end

# class API::V1::GuestSerializer < SimpleSerializer
#   attributes :id,
#              :first_name,
#              :last_name
# end

# class API::V1::TableSerializer < SimpleSerializer
#   attributes :id,
#              :number,
#              :max_covers
# end

# class API::V1::ReservationSerializer < SimpleSerializer
#   iso_timestamp_columns %i[created_at updated_at start_time]
#   attributes :id,
#              :status,
#              :covers,
#              :walk_in,
#              :start_time,
#              :duration,
#              :notes,
#              :created_at,
#              :updated_at
#   belongs_to :restaurant, serializer: API::V1::RestaurantSerializer
#   has_one :guest, serializer: API::V1::GuestSerializer
#   has_many :tables, serializer: API::V1::TableSerializer
#   def notes
#     object.notes.presence
#   end
# end
