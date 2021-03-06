class BlogsController < ApplicationController
  before_action :login_check, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_blog, only: [:show, :edit, :update,:destroy] 
  
  def index
    @blogs = Blog.all

  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
      @blog.image.retrieve_from_cache! params[:cache][:image]
    else
      @blog = Blog.new
    end
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache!  params[:cache][:image]
    
    if @blog.save
      BlogMailer.blog_mail(@blog).deliver
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render 'new'
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    @blog = Blog.find(params[:id])   
  end

  def update
    @blog = Blog.find(params[:id])   
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end
  

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def login_check
  if current_user.nil?
    flash[:notice] = "権限がありません"
    redirect_to "/sessions/new"
  end   
  end 
  
end