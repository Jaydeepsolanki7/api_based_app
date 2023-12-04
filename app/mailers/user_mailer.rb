class UserMailer < ApplicationMailer
  def welcome_email(send_at = 1.hour.from_now, user)
    @user = user
    mail(
      to: @user.email, 
      subject: 'Welcome new User') do |format| format.html { render 'welcome_email' } end
  end
end
