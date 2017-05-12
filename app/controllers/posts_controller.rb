class PostsController < ApplicationController

  def index
    # @posts = Post.all
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    # jesli user nie jest rowny zalogowanemu to wychodze
    return unless post_params[:user_id] == current_user.id.to_s
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post created'
      redirect_to @post
    else
      flash[:alert] = 'Post not created'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit; end

  private

  def post_params
    params.require(:post).permit(:title, :description, :expiration_date, :user_id)
  end

end