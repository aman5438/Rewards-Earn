class WelcomeMailer < ApplicationMailer

  def mailer(id)
    user = User.find_by(id: id)
    mail(to: user.email, subject: "Welcome to SPACEMAN CHALLENGE")
  end
end
