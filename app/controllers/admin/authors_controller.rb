class Admin::AuthorsController < Admin::BaseController
  before_action :set_author, only: [:show, :edit, :update,:destroy]

  def index
    @authors = policy_scope(Author)
  end

  def show
    authorize @author
  end

  def new
    @author = Author.new
    authorize @author
  end

  def edit
    authorize @author
  end

  def create
    @author = Author.new(author_params)
    authorize @author
    if @author.save
      flash[:success] = t('messages.created', model: @author.class.model_name.human)
      redirect_to [:admin, @author]
    else      
      render :new
    end
  end

  def update
    authorize @author
    if @author.update(author_params)
      flash[:success] = t('messages.updated', model: @author.class.model_name.human)
      redirect_to [:admin, @author]
    else      
      render :edit
    end
  end

  def destroy
    authorize @author
    @author.destroy
    flash[:success] = t('messages.deleted', model: @author.class.model_name.human)
    redirect_to admin_authors_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def author_params
      params.require(:author).permit(:name)
    end
end
