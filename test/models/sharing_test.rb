require 'test_helper'

class SharingTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many_attached(:files)
  end
end
