module ApplicationHelper
  include ErrorHelper
  include PostsHelper

  # Renders success json when no return payload is due
  def success_request(message = 'Request success !', status = :ok)
    render json: {
      title: 'Your request has been accepted !',
      message: message
    }, status: status
  end

  def render_user(message, user = current_user)
    avatar = rails_blob_url(user.avatar) if user.avatar.attached?
    posts = []
    Post.where(user_id: user.id).each do |post|
      posts << format_post(post)
    end
    favorite_posts = []
    user.favorite_posts.each do |favorite|
      favorite_posts << format_post(favorite.post)
    end
    render json: {
      message: message,
      user: user,
      avatar: avatar,
      posts: posts,
      favorite_posts: favorite_posts
    }, status: :ok
  end

  def split_endpoints
    @page = if params[:page]
              params[:page].to_i
            else
              1
            end
  end
end