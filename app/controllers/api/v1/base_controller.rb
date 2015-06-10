
module API::V1
  class BaseController < ::ApplicationController
    skip_before_filter  :verify_authenticity_token

    protected
    def ensure_valid_access_token!
      access_token || render_unauthorized
    end

    def access_token
      @access_token ||= AccessToken.from_request(request)
    end

    def current_user
      access_token.user if access_token
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Bearer realm="Application"'
      render json: { errors: 'Bad credentials' }, status: :unauthorized
    end
  end
end



# require "grape-swagger"

# module API
#   module V1
#     class Base < Grape::API
#       mount API::V1::Users
#         # mount API::V1::Users::Dogs
#       # mount API::V1::AnotherResource

#       add_swagger_documentation(
#         api_version: "v1",
#         hide_documentation_path: true,
#         mount_path: "/api/v1/swagger_doc",
#         hide_format: true
#       )
#     end
#   end
# end