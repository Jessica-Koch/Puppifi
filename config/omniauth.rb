Rails.application.config.middleware.use OmniAuth::Builder do |variable|
  provider :linkedin, ENV['']
end
  
