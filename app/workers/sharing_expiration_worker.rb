class SharingExpirationWorker
  include Sidekiq::Worker
  attr_reader :record

  def perform(sharing_id)
    return unless @record = find_record(sharing_id) && destroy_bg_jobs

    record.destroy
  end

  private

  def find_record(record_id)
    Sharing.find_by(id: record_id)
  end

  def destroy_bg_jobs
    record.bg_jobs.find_by(job_type: self.class.name, worker_job_id: jid)&.destroy
  end
end
