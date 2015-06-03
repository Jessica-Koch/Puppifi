require "net/http"
require "net/https"

class LinkedinAuthenticator 
  LINKED_IN_OAUTH_PATH = " https://api.linkedin.com/uas/oauth/requestToken"

  def initialize(auth_code)
    @auth_code = auth_code
  end

  def namme
    linkedin_user(:login)
  end

  private
  def linkedin_user
    @linkedin_user ||= linkedin_client.user
  end

# used to extract login fron linkedin and our name method
  def linkedin_client
    OmniAuth::Client.new(access_token: access_token)
  end

  def access_token
    linkedin_response["access_token"]
  end

  def token_type
    linkedin_response["token_type"]
  end

  def scope
    github_response["scope"]
  end

  def linkedin_response
    @linkedin_response ||= JSON.parse(res.body)
  end

  def res
    http.request(req)
  end

  def req
    # net http request returns oauth token
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
