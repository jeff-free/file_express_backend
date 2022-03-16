class Sharing < ApplicationRecord
  has_many_attached :files
  has_secure_token
  has_many :bg_jobs, as: :job_runnable, dependent: :delete_all

  after_commit :set_expiration, on: :create

  private

  def set_expiration
    bg_jobs.launch_async_worker(self, SharingExpirationWorker, interval: 1.day)
  end
end
