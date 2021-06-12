# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  :port => 587,
  :address => 'smtp.mailgun.org',
  :user_name => Rails.application.credentials.dig(Rails.env.to_sym,:smtp, :user_name), # This is the string literal 'apikey', NOT the ID of your API key
  :password => Rails.application.credentials.dig(Rails.env.to_sym,:smtp, :password), # This is the secret sendgrid API key which was issued during API key creation
  :domain => 'smtp.mailgun.org',
  :authentication => :plain,
  # :enable_starttls_auto => true
}

ActionMailer::Base.delivery_method = :smtp
