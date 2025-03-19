# frozen_string_literal: true

# Address model used to validate form entry from client
class Address
  include ActiveModel::Model

  attr_accessor :street, :city, :state

  validates :street, :city, :state, presence: true

  def formatted
    "#{street}, #{city}, #{state}"
  end
end
