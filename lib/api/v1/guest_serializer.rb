# frozen_string_literal: true

require_relative './../../../simple_serializer'

module Api
  module V1
    class GuestSerializer < SimpleSerializer
      attributes :id,
                 :last_name,
                 :first_name
    end
  end
end
