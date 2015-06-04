module V1
  # session controller can fetch old sessions 
  class SessionsController < ApplicationController
    # skipped because ember and rails are on different domains
    skip_before_action :verify_authenticity_token

    def create
      if user
        render json: user, status: :created
      else
        render nothing: true, status: :bad_request
      end
    end

    private
    def user
      @_user ||= fetch_or_create_user
    end

    def fetch_or_create_user
      if linkedin_auth_code
        find_or_create_user_from_linkedin
      elsif token
        User.find_by(token: token)
      end
    end


    def find_or_create_user_from_linkedin
      # create a new instance of Linkedinauthenticator class passed auth token
      linkedin_authenticator = LinkedinAuthenticator.new(linkedin_auth_code)
      # passes the instance of githubauthenticator to instantiate a class that does not yet exist (userfactory)
      # user factory returns a user  
      user_factory = UserFactory.new(linkedin_authenticator)
      user_factory.find_or_create_user
    end

    def token
      @_token ||= session_params[:token]
    end

    def linkedin_auth_code
      @_linkedin_auth_code ||= session_params[:'linkedin-auth-code']
    end

    def session_params
      params.permit(:'linkedin-auth-code', :token)
    end
  end
end
     