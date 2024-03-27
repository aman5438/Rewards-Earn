class InvitationMailer < ApplicationMailer

  def send_email(id,email)
    @user = User.find(id)
    @email = email
    mail(to: email, subject: 'Welcome to SPACEMAN CHALLENGE brought to you by Supreme Unbeing')
  end

end