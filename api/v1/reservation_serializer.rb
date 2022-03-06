# frozen_string_literal: true

require_relative '../../simple_serializer'

module Api
  module V1
    class ReservationSerializer < SimpleSerializer
      # iso_timestamp_columns %i[created_at updated_at start_time]
      attributes :id,
                 :status,
                 :covers,
                 :walk_in,
                 :start_time,
                 :duration,
                 :notes
      #  :created_at,
      #  :updated_at
      # belongs_to :restaurant, serializer: API::V1::RestaurantSerializer
      # has_one :guest, serializer: API::V1::GuestSerializer
      # has_many :tables, serializer: API::V1::TableSerializer
      # def notes
      #   object.notes.presence
      # end

      def created_at
        Time.current
      end

      def updated_at
        Time.current
      end
    end
  end
end

# x = Api::V1::ReservationSerializer.new(reservation)
