class User < ActiveRecord::Base
  validates :name, presence: true, uniquness: true
  before_create :generate_token
  has_many :dogs, dependent: :destroy
end
