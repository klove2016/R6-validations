class Order < ApplicationRecord
  validates_associated :customer
  belongs_to :customer
  validates :product_name, :product_count, :customer, presence: true
  validates :product_count, numericality: { greater_than: 0  }
end
