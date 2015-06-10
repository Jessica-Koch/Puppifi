require "net/http"
require "net/https"

class LinkedinAuthenticator 
  # LINKED_IN_OAUTH_PATH = "https://linkedin.com/uas/oauth2/authorization?response_type=code"

  LINKED_IN_OAUTH_PATH = "https://linkedin.com/login/oauth/access_token"

  def initialize(auth_code)
    @auth_code = auth_code
  end

  def name
    linkedin_user[:login]
  end


  private

  def linkedin_user
    @linkedin_user ||= linkedin_client.user
  end

  def linkedin_client
    OAuth2::Client.new(access_token: access_token)
  end

  def access_token
    linkedin_response["access_token"]
  end

  def token_type
    linkedin_response["token_type"]
  end

  def scope
    linkedin_response["scope"]
  end

  def linkedin_response
    @linkedin_response ||= JSON.parse(res.body)
  end

  def res
    http.request(req)
  end

  def req
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(post_data)
    req["Accept"] = "application/json"
    req
  end

  def http
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http
  end

  def uri
    URI.parse(LINKED_IN_OAUTH_PATH)
  end

  def post_data
    {
      "client_id" => ENV["LINKED_IN_CLIENT_ID"],
      "client_secret" => ENV["LINKED_IN_CLIENT_SECRET"],
      "code" => @auth_code
    }
  end
end
