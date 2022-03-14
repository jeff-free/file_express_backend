require 'test_helper'

class SharingsControllerTest < ActionDispatch::IntegrationTest
  describe 'POST /sharings' do
    context 'files in params are not composed by valid signatures' do
      it 'responds error message in json format with status code 422' do
        invalid_signatures = ['invalid_signature']
        post '/sharings', params: { sharing: { files: invalid_signatures } }
        expect(response.status).must_equal(422)
        expect(response.body).must_equal({
          status: 422,
          message: I18n.t('api.application_messages.unprocessable_entity'),
          data: nil
        }.to_json)
      end

      context 'record failed to save' do
        it 'responds error message in json format with status code 400' do
          # sharing = Minitest::Mock.new
          # sharing.expect(:save!, proc { raise ActiveRecord::RecordInvalid })
          # Sharing.stub(:new, sharing) do
          #   post '/sharings', params: { sharing: { files: [] } }
          #   expect(response.status).must_equal(400)
          #   expect(response.body).must_equal({
          #     status: 400,
          #     message: I18n.t('api.application_messages.bad_request'),
          #     data: nil
          #   }.to_json)
          # end
        end
      end

      context 'record successfully saved' do
        it 'responds with status code 200' do
          # invalid_signatures = ['invalid_signature']
          # post '/sharings', params: { sharing: { files: invalid_signatures } }
        end
      end
    end
  end
end
