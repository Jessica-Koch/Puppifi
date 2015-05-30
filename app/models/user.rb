class User < ActiveRecord::Base
  has_many :dogs, dependent: :destroy
end
