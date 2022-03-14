module Rendering
  extend ActiveSupport::Concern

  RETURN_CODES = [
    HTTP_CODE_BAD_REQUEST = 400,
    HTTP_CODE_UNAUTHORIZED = 401,
    HTTP_CODE_UNPROCESSABLEENTITY = 422,
    HTTP_CODE_RECORDNOTFOUND = 404,
    HTTP_CODE_PAGEHASEXPIRED = 422
  ].freeze

  APPLICATION_MESSAGES = [
    HTTP_MESSAGE_BADREQUEST = I18n.t('api.application_messages.bad_request'),
    HTTP_MESSAGE_UNAUTHORIZED = I18n.t('api.application_messages.unauthorized'),
    HTTP_MESSAGE_UNPROCESSABLEENTITY = I18n.t('api.application_messages.unprocessable_entity'),
    HTTP_MESSAGE_RECORDNOTFOUND = I18n.t('api.application_messages.record_not_found'),
    HTTP_MESSAGE_PAGEHASEXPIRED = I18n.t('api.application_messages.page_has_expired'),
  ].freeze

  def get_result_json(code, message, data = nil)
    { status: code, message: message, data: data }.to_json
  end

  def get_exception_message(exception, default_message)
    msg = exception.message
    if msg == exception.class.name
      default_message
    else
      msg
    end
  end
end
