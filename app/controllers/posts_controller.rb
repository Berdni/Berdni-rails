class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else
      redirect_to root_path, notice: 'Невозможно добавить сообщение'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
