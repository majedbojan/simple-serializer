# frozen_string_literal: true

module Api
  module V1
    class TableSerializer < SimpleSerializer
      attributes :id,
                 :number,
                 :max_covers
    end
  end
end
