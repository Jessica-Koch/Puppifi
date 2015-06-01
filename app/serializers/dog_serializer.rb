class DogSerializer < ActiveModel::Serializer
  attributes :id, :"name,", :"age,", :"gender,", :user_id
end
