class ApplicationController < ActionController::API
  include Rendering

  rescue_from ActiveRecord::RecordNotFound, with: :respond_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :respond_unprocessable_entity
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :respond_unprocessable_entity

  def respond_bad_request(exception)
    message = get_exception_message(exception, HTTP_MESSAGE_BADREQUEST)
    render json: get_result_json(HTTP_CODE_BADREQUEST, message),
           status: HTTP_CODE_BADREQUEST
  end

  def respond_record_not_found(exception)
    message = HTTP_MESSAGE_RECORDNOTFOUND
    render json: get_result_json(HTTP_CODE_RECORDNOTFOUND, message),
           status: HTTP_CODE_RECORDNOTFOUND
  end

  def respond_unprocessable_entity(exception)
    message = get_exception_message(exception, HTTP_MESSAGE_UNPROCESSABLEENTITY)
    render json: get_result_json(HTTP_CODE_UNPROCESSABLEENTITY, message),
           status: HTTP_CODE_UNPROCESSABLEENTITY
  end
end
