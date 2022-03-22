class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    message = 'Profile of the current user'
    render_user(message)
  end

  def show
    @profile = User.find(params[:id])
    message = 'This is the profile you asked :'
    render_user(message, @profile)
  end

  def update
    error_formatter(current_user) unless current_user.update(user_params)
    message = 'Profile correctly updated !'
    render_user(message)
  end

  def destroy
    error_formatter(current_user) unless current_user.destroy
    message = 'User deleted from the database !'
    success_request(message)
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :username,
        :description,
        :github_url,
        :personal_url,
        :favorite_theme
      )
  end
end
