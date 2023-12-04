class UserMailerWorkerWorker
  include Sidekiq::Worker

  def perform(send_at = 1.hour.from_now, user_id)
    user = User.find_by(id: user_id)
    return unless user

    UserMailer.welcome_email(user).deliver_now
  end
end
