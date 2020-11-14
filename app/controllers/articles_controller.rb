# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]

  def index
    articles = Article.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded articles', data: articles }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the article', data: @article }
  end

  def create
    article = Article.create!(article_params)
    render json: { status: 'SUCCESS', data: article }
  end

  def update
    @article.update!(article_params)
    render json: { status: 'SUCCESS', message: 'Updated the article', data: @article }
  end

  def destroy
    @article.destroy!
    render json: { status: 'SUCCESS', message: 'Deleted the article', data: @article }
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.permit(:title)
  end
end
