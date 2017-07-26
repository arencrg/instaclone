class PostsController < ApplicationController

before_action :authenticate_user!

def index
 @posts = Post.order('id DESC').all
end

def new  
  @post = Post.new
end  

def create  
  @post = Post.create(post_params.merge(user_id: current_user.id))
  respond_to do |format|
    if @post.save
      format.html { redirect_to posts_path, notice: 'Insta was successfully created.' }
      format.json { render :show, status: :created, location: @post }
    else
      format.html { render :new }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end

def show  
  @post = Post.find(params[:id])
end 

def edit  
  @post = Post.find(params[:id])
end

def update  
  @post = Post.find(params[:id])
  @post.update(post_params)
  redirect_to(post_path(@post))
end

def destroy
    @post = Post.find(params[:id])
    if @post.present?
      @post.destroy
    end
    redirect_to posts_path
end

private

    def post_params  
      params.require(:post).permit(:image, :caption)
    end  
    
    def set_post
      @post = Post.find(params[:id])
    end
    
end
