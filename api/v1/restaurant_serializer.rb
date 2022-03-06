# frozen_string_literal: true

module Api
  module V1
    class RestaurantSerializer < SimpleSerializer
      attributes :id,
                 :name,
                 :address
      def address
        object.address if object.address.to_s.length.positive?
      end
    end
  end
end
