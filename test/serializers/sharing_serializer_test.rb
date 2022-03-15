require 'test_helper'

class SharingSerializerTest < ActiveSupport::TestCase
  describe '#serialized_data' do
    it 'returns serialized data' do
      files = Minitest::Mock.new
      files.expect(:map, [{ filename: 'filename', url: 'file_url' }])
      sharing = Minitest::Mock.new
      sharing.expect(:token, 'token')
      sharing.expect(:files, files)
      serializer = SharingSerializer.new(sharing)
      expect(serializer.serialized_data).must_equal(
        {
          data: {
            token: 'token',
            files: [{ filename: 'filename', url: 'file_url' }]
          }
        }.to_json
      )
    end
  end
end
