class UserMailer < ActionMailer::Base
  default from: "support@asiafan.net"

  def password_reset(user)
    @user = user
    mail to: "#{@user.first_name} #{@user.last_name}<#{@user.email}>", subject: "Asia Fan - Password Reset"
  end
end