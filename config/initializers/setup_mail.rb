require 'development_mail_interceptor'
ActionMailer::Base.smtp_settings = {
  address: "mail.asiafan.net",
  port: 587,
  domain: "asiafan.net",
  authentication: "plain",
  enable_starttls_auto: false,
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD']

}

ActionMailer::Base.default_url_options[:host] = "secret-fjord-8839.herokuapp.com"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?