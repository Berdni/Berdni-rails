class PostsController < ApplicationController
  include CableReady::Broadcaster
  load_and_authorize_resource

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      cable_ready['feed'].insert_adjacent_html(
        selector: '#pinned-post',
        position: 'afterend',
        html: render_to_string(partial: 'post', locals: { post: @post, editable: false })
      )
      cable_ready.broadcast
      redirect_to root_path
    else
      # TODO Flash messages
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    cable_ready['feed'].remove(
      selector: '#post_' + @post.id.to_s
    )
    cable_ready.broadcast
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
