module V1
  class SessionsController < ApplicationController 
    # skipped because ember and rails are on different domains
    skip_before_action :verify_authenticity_token 

    def create 
      # create a new instance of Linkedinauthenticator class passed auth token
      linkedin_authenticator = LinkedinAuthenticator.new(linkedin_auth_code)
      # passes the instance of githubauthenticator to instantiate a class that does not yet exist (userfactory)
      # user factory returns a user  
      user_factory = UserFactory.new(linkedin_authenticator)
      user = user_factory.find_or_create_user

      render json: user, status: :created
    end

    private

    def linkedin_auth_code
      params.require(:'linkedin-auth-code')
    end
  end
end
