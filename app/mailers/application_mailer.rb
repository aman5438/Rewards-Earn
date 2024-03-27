class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.default_from_address
  layout "mailer"
end
