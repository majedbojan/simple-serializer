# frozen_string_literal: true

require_relative '../../simple_serializer'
require_relative './restaurant_serializer'

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
                 :notes,
                 :created_at,
                 :updated_at
      belongs_to :restaurant, serializer: Api::V1::RestaurantSerializer
      has_one :guest, serializer: Api::V1::GuestSerializer
      has_many :tables, serializer: Api::V1::TableSerializer

      def notes
        object.notes if object.notes.to_s.length.positive?
      end

      def created_at
        Time.now.iso8601
      end

      def updated_at
        Time.now.iso8601
      end

      def start_time
        object.start_time&.iso8601
      end
    end
  end
end
