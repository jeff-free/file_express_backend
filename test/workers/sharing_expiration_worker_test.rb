require 'test_helper'

class SharingExpirationWorkerTest < ActiveSupport::TestCase
  describe '#perform' do
    context 'record cannot be found' do
      it 'does not perform the task' do
        worker = SharingExpirationWorker.new
        Sidekiq::Testing.inline! do
          Sharing.stub(:find_by, nil) do
            expect(worker.perform(1)).must_be_nil
          end
        end
      end
    end

    context 'record can be found' do
      context 'bg_jobs.destroy returns nil' do
        it 'does not perform the task' do
          sharing = Minitest::Mock.new
          bg_jobs = Minitest::Mock.new
          sharing.expect(:bg_jobs, bg_jobs)
          bg_jobs.expect(:find_by, nil, [{ job_type: 'SharingExpirationWorker', worker_job_id: nil }])
          worker = SharingExpirationWorker.new
          Sidekiq::Testing.inline! do
            Sharing.stub(:find_by, sharing) do
              worker.stub(:record, sharing) do
                expect(worker.perform(1)).must_be_nil
              end
            end
          end
        end
      end

      context 'bg_jobs.destroy returns truthy value' do
        it 'sends #destroy to record' do
          sharing = Minitest::Mock.new
          bg_jobs = Minitest::Mock.new
          bg_job = Minitest::Mock.new
          sharing.expect(:destroy, 'destroyed')
          sharing.expect(:bg_jobs, bg_jobs)
          bg_jobs.expect(:find_by, bg_job, [{ job_type: 'SharingExpirationWorker', worker_job_id: nil }])
          bg_job.expect(:destroy, true)
          worker = SharingExpirationWorker.new
          Sidekiq::Testing.inline! do
            Sharing.stub(:find_by, sharing) do
              worker.stub(:record, sharing) do
                expect(worker.perform(1)).must_equal('destroyed')
              end
            end
          end
        end
      end
    end
  end
end
