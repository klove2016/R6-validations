class Order < ApplicationRecord
  validates_associated :customer
  belongs_to :customer
  validates :product_name, :product_count, :customer, presence: true
  validates :product_count, numericality: { only_integer: true }
  validate :customer_id_exists

  validate :customer_id_exists


  def customer_id_exists
    errors.add(:customer, "customer_id does not correspond to an exisiting customer record") unless Customer.exists?(customer_id)
  end
end
