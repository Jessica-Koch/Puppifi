Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['LINKEDIN_CLIENT_KEY'], ENV['LINKEDIN_CLIENT_SECRET']
end

OmniAuth.config.on_failure = Proc.new {|env|
OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}