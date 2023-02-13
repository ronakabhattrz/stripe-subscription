class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: { case_sensitive: false }
  validates :stripe_id, presence: true, uniqueness: true
  has_one :subscription
  before_validation :create_stripe_reference, on: :create

  def create_stripe_reference
    response = Stripe::Customer.create(email: email)
    self.stripe_id = response.id
  end

  def retrieve_stripe_reference
    Stripe::Customer.retrieve(stripe_id)
  end
end
