# test/mailers/previews/user_mailer_preview.rb

class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end
end
