class Dog < ActiveRecord::Base
  belongs_to :user

  validates :name, :age, :gender, :user_id, presence: true

end