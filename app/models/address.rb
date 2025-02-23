# frozen_string_literal: true

# Address model used to validate form entry from client
class Address
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment

  DEFAULT_ADDRESS = '1500 Sugar Bowl Dr, New Orleans, LA'

  attr_accessor :street, :city, :state

  validates :street, :city, :state, presence: true

  def formatted
    "#{street}, #{city}, #{state}"
  end

  def self.default_attributes
    attr_hash = {}
    attributes = %i[street city state]
    DEFAULT_ADDRESS.split(',').each_with_index do |attribute, index|
      attr_hash[attributes[index]] = attribute
    end
    attr_hash
  end
end
