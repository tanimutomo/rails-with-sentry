# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :set_raven_context

  include ActionController::HttpAuthentication::Token::ControllerMethods
  class ActionController::Forbidden < ActionController::ActionControllerError; end

  rescue_from StandardError, with: :error500
  rescue_from ActiveRecord::ActiveRecordError, with: :error422
  rescue_from ActiveRecord::RecordInvalid, with: :error400
  rescue_from ActiveRecord::RecordNotUnique, with: :error403
  rescue_from ActiveRecord::RecordNotFound, with: :error404
  rescue_from ActiveRecord::NotNullViolation, with: :error400
  rescue_from ActionController::BadRequest, with: :error400
  rescue_from ActionController::ParameterMissing, with: :error400
  rescue_from ActionController::InvalidAuthenticityToken, with: :error401
  rescue_from ActionController::Forbidden, with: :error403
  rescue_from ActionController::RoutingError, with: :error404

  def error500(err)
    render json: { error: err.message }, status: :internal_server_error
  end

  def error422(err)
    render json: { error: err.message }, status: :unprocessable_entity
  end

  def error404(err)
    render json: { error: err.message }, status: :not_found
  end

  def error403(err)
    render json: { error: err.message }, status: :forbidden
  end

  def error401(err)
    render json: { error: err.message }, status: :unauthorized
  end

  def error400(err)
    render json: { error: err.message }, status: :bad_request
  end

  private

  def set_raven_context
    Raven.user_context(id: 1) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
