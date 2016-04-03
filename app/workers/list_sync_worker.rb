class ListSyncWorker
  include Sidekiq::Worker

  def perform(id)
    list = List.find(id)
    return if list.attempted_at.present? && list.attempted_at > 1.minute.ago
    list.update! attempted_at: DateTime.now
    list.users.each(&:schedule_sync!)
    list.update! generated_at: 5.minutes.from_now
  end
end
