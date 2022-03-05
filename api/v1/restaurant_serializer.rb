# frozen_string_literal: true

module Api
  module V1
    class RestaurantSerializer < SimpleSerializer
      attributes :id,
                 :name,
                 :address
      def address
        object.address.presence
      end
    end
  end
end
