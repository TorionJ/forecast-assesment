# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  describe 'Validations' do
    context 'when all attributes are present' do
      it 'should return valid' do
        address = Address.new(street: '10110 binary ave', city: 'microchip', state: 'solid')
        assert(address.valid?)
      end
    end

    context 'when street attribute is missing' do
      it 'should return invalid' do
        address = Address.new(street: nil, city: 'microchip', state: 'solid')
        refute(address.valid?)
      end
    end

    context 'when city attribute is missing' do
      it 'should return invalid' do
        address = Address.new(street: '10110 binary ave', city: nil, state: 'solid')
        refute(address.valid?)
      end
    end

    context 'when state attribute is missing' do
      it 'should return invalid' do
        address = Address.new(street: '10110 binary ave', city: 'microchip', state: nil)
        refute(address.valid?)
      end
    end
  end

  describe '#formatted' do
    it 'should format the address by <street>, <city>, <state>' do
      address = Address.new(street: '10110 binary ave', city: 'microchip', state: 'solid')
      assert_equal(address.formatted, '10110 binary ave, microchip, solid')
    end
  end
end
