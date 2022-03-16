class BgJob < ApplicationRecord
  belongs_to :job_runnable, polymorphic: true

  def self.launch_async_worker(job_runnable, worker_class, params = {}, perform_method: :perform_async, interval: nil)
    args = [params.merge!(record_id: job_runnable.id)]
    args.prepend(interval) unless perform_method == :perform_async
    bg_job_id = worker_class.send(perform_method, *args)
    create(job_runnable: job_runnable, job_type: worker_class.to_s, worker_job_id: bg_job_id)
  end
end
