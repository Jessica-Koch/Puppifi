# creating a base class for Rails app 
# going to follow /api/v1 route versioning 
# piggy backed controllers directlyr because of autolading from Rails 

module API
  class Base < Grape::API
    mount API::V1::Base
  end
end