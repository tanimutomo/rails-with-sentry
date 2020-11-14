# frozen_string_literal: true

class NothingsController < ApplicationController
  def index
    raise StandardError, 'raise in :index'
  end

  def show
    binding.pry
    raise ActionController::InvalidAuthenticityToken 'raise in :show'
  end

  def create
    raise ActionController::BadRequest 'raise in :create'
  end

  def update
    raise ActionController::ParameterMissing 'raise in :update'
  end

  def destroy
    raise ActionController::Forbidden 'raise in :destroy'
  end
end
