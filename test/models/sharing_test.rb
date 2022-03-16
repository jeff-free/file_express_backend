require 'test_helper'

class SharingTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many_attached(:files)
    should have_many(:bg_jobs).dependent(:delete_all)
  end

  describe 'callbacks' do
    describe 'after_commit' do
      describe 'on: :create' do
        it 'sends .launch_async_worker to bg_jobs' do
          bg_jobs_spy = Spy.on(BgJob, :launch_async_worker)
          create(:sharing)
          assert bg_jobs_spy.has_been_called?
        end
      end
    end
  end
end
