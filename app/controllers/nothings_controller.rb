# frozen_string_literal: true

class NothingsController < ApplicationController
  def index
    raise StandardError.new('raise in :index')
  end

  def show
    raise ActionController::InvalidAuthenticityToken.new('raise in :show')
  end

  def create
    raise ActionController::BadRequest.new('raise in :create')
  end

  def update
    raise ActionController::ParameterMissing.new('raise in :update')
  end

  def destroy
    raise ActionController::Forbidden.new('raise in :destroy')
  end
end
