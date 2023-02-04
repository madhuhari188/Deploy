class PostsController < ApplicationController
  before_action :set_post, only: %i[  show edit update destroy]
  before_action :get_topic
                # only: %i[ new show create edit update destroy ]
  before_action :authenticate_user!

  protect_from_forgery except: "read_status"
  # load_and_authorize_resource
                # only: %i[ show], except: [:update,:destroy]
  # GET /posts or /posts.json
  def index
    # par = params[:ftr_post]
    # if params.has_key?(:ftr_post)
    # @posts =
    # # debug
    # else
    @posts =(if @topic.present?
               @topic.posts.all.includes(:tags,post_image_attachment: :blob)
             elsif params.has_key?(:ftr_post)
               Post.includes(:topic,:tags,:user,post_image_attachment: :blob).ftr_post(params.dig(:ftr_post,:start_date),params.dig(:ftr_post,:end_date)).paginate(page: params[:page])
             else
               Post.includes(:topic,:tags,:user,post_image_attachment: :blob)
             end).paginate(page: params[:page])
                 # .includes(post_image_attachment: :blob)

    # end
     # if params.has_key?(:topic_id)
     #   @topic = Topic.find(params[:topic_id])
     #   @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
     # else
     #   @posts = Post.includes(:tags,:post_image_attachment).paginate(page: params[:page])
     #  # @posts = Post.all
     # end
     # @post = @topic.posts.build
    # render :index
  end

  def mypost
    @posts = Post.accessible_by(current_ability, :edit)
  end
  def po
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    # @topic = Topic.find(params[:topic_id])
    # @post = Post.find(params[:id])
    # @comment = @post.comments.build
    # @rating = @post.ratings.build

    # # if you are not using nested routes then you can find out associated article by
    # @topic = @post.topic
  end

  # GET /posts/new
  def new
    # @post = Post.new
    @post = @topic.posts.build
    @post.tags.build
  end

  # GET /posts/1/edit
  def edit
    authorize! :edit, @post
    # @post.tags.build
  end

  def read_status
    # c = params[:]4
    @post = Post.find(params[:post_id])
    post = @post
    # @user = current_user.id
    user = current_user
    if @post.users.exists?(:id=>current_user.id)
      respond_to do|format|
        format.json {head :ok}
      end
    else
      user.posts << post
      respond_to do|format|
        format.json {head :ok}
      end
    end
  end

  def status
    # post = Post.find()
    # issue = Issue.find(params[:id])
    # @account = current_user.id
    # @account.postsusersreadstatus.create(issue: issue)
    # c = current_user.id
    # @posts_users_read_status << @posts
    post = Post.find(params[:id])
    user = User.find(params=(current_user.id))
    if @post.users.where
      debug
    else
      user.posts << post
    end
  end
  # POST /posts or /posts.json
  def create
    # @post = Post.new(post_params)
    @post = @topic.posts.build(post_params)
    @post.user_id = current_user.id
    # create_or_delete_posts_tags(@post, params[:post][:tags].reject(&:blank?))
    respond_to do |format|
      if @post.save
        format.js
        format.html { redirect_to [@topic, @post], notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # create_or_delete_posts_tags(@post, params[:post][:tags].reject(&:blank?))
    #byebug
    authorize! :edit, @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to topic_posts_url(@post.topic_id), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize! :destroy, @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to topic_posts_url(@post.topic_id), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body,:post_image,tag_ids:[].reject(&:blank?),tags_attributes:  [:id,:tag] )
    end

  # def search_params
  #   params.require(:ftr_post).permit(:start_date, :end_date)
  # end
  def get_topic
    @topic = Topic.find(params[:topic_id]) if params[:topic_id].present?
  end

  # def create_or_delete_posts_tags(post,tags)
  #   post.tags.destroy_all
  #   # tags = tags.strip.split(',')
  #   # tags = tags.reject(&:blank?)
  #   tags.each do |tag|
  #     post.tags << Tag.find_or_create_by(tag: tag)
  #   end
  # end



end
