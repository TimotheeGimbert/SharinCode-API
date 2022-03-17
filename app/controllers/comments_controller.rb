class CommentsController < ApplicationController
  include CommentsHelper

  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_comment, only: %i[update delete]

  def create
    @comment = Comment.new(comment_params)
    error_formatter(@comment) && return unless @comment.save

    render_comment_json(@comment)
  end

  def update
    unauthorized_user_error && return if current_user.id != @comment.user.id
    error_formatter(@comment) && return unless @comment.update(comment_params)

    render_comment_json(@comment)
  end

  def destroy
    unauthorized_user_error && return if current_user.id != @comment.user.id

    @comment.destroy
  end

  private

  def comment_params
    params.permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
