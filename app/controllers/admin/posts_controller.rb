class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:show, :edit, :update,:destroy]

  def index
    @posts = policy_scope(Post)
  end

  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      flash[:success] = t('messages.created', model: @post.class.model_name.human)
      redirect_to [:admin, @post]
    else      
      render :new
    end
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:success] = t('messages.updated', model: @post.class.model_name.human)
      redirect_to [:admin, @post]
    else      
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    flash[:success] = t('messages.deleted', model: @post.class.model_name.human)
    redirect_to admin_posts_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def post_params
      if 'DDDL' == 'DDDL'
        params.require(:post).permit(:content, :author_ids)
      elsif true
        params.require(:post).permit(:content, author_ids: [])
      end
    end
end
