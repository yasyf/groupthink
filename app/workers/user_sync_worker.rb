class UserSyncWorker
  include Sidekiq::Worker

  def perform(id, oldest, newest)
    User.find(id).sync oldest, newest
  end
end
