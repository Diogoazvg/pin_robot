# frozen_string_literal: true

module Mutations
  class Test < BaseMutation
    argument :coupon_code, String, required: true

    type Types::NewTestType

    def resolve(**_attrs)
      { test_return: 'De bom!' }
    end
  end
end
