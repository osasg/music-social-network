module MusicSocialNetwork
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :check_access, only: [:edit, :update, :destroy]

    def index
      @posts = Post.all
    end

    def show
    end

    def new
      @post = Post.new
    end

    def edit
    end

    def create
      @post = Post.new(post_params)
      @post.user = current_user

      respond_to do |format|
        if @post.save
          format.html { redirect_to root_path, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to root_path, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      activities = PublicActivity::Activity.where(trackable_id: @post.id);

      activities.destroy_all
      @post.destroy

      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:attachment, :content)
      end

      def check_access
        unless current_user.posts.where(id: params[:id]).first.present?
          redirect_to request.referer
        end
      end
  end
end
