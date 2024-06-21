class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index] # not authorized user can only access post page
  before_action :authorize_user, only: [:new, :create] # authorized user
  before_action :set_user, only: [:new, :create] # look for User only for the url /new and /create

  def index
    @posts = Post.all
    # render :json => @post
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user
    if params[:user_id].to_i != current_user.id
      redirect_to root_path, alert: "You are not authorized to access this user's posts"
    end
  end
end
