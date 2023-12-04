class UserMailerWorkerWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    UserMailer.welcome_email(1.hour.from_now, user).deliver_now
  end
end
