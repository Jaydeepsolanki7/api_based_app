class PeriodicEmailWorkerJob < ApplicationJob
  include Sidekiq::Job

  def perform(user_id)
    debugger
    user = User.find(user_id)
    UserMailer.periodic_email(user).deliver_now
  end
end
