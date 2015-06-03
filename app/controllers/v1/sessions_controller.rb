module V1
  class SessionsController < ApplicationController 
    skip_before_action :verify_authenticity_token 

    def create 
      linkedin_authenticator = LinkedinAuthenticator.new(linkedin_auth_code)
      user_factory = UserFactory.new(linkedin_authenticator)
      user = user_factory.find_or_create_user

      render json: user, status: :created
    end

    private

    def linkedin_auth_code
      params.require(':linkedin_auth_code')
    end
  end
end
