class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]

  include SessionConcern 
  before_action :is_logged_in, only: %i[createlike removelike]
  before_action :set_user, only: %i[createlike removelike]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def createlike
    @like = Like.new
    @like.user = User.find(params[:user_id])
    @like.post = Post.find(params[:post_id])
    @like.save
    if (params[:isProfilePage] == "false")
      redirect_to feed_page_path
    else
      redirect_to profile_page_path(name: @like.post.user.name)
    end
  end

  def removelike
    @like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    @like.destroy
    if (params[:isProfilePage] == "false")
      redirect_to feed_page_path
    else
      redirect_to profile_page_path(name: @like.post.user.name)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
