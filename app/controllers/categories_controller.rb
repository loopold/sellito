class CategoriesController < ApplicationController
  # TODO: authorization with Pundit gem
  
  # before_action :fetch_category, only: [:show, :edit, :update, :destroy]
  before_action :fetch_category, only: %i(show edit update destroy)

  def index
    # binding.pry
    @categories = Category.all
  end

  def new
    @category = Category.new
    authorize @category
  end
 
  def create
    # narzedzie do debugowania
    # binding.pry
    # potem w konsoli mozesz np. params 
    #  
    # raise params.to_yaml
    # Category.create(category_params)
    @category = Category.new(category_params)
    authorize @category
    @category.valid? ? create_category : handle_category_validation_failed
  end

  # metody ktore nic nie robia w jednej linijce
  def show; end

  def edit
    authorize @category
  end

  def update
    authorize @category
    @category.update_attributes(category_params)
    redirect_to @category
  end

  def destroy
    authorize @category
    @category.destroy!
    flash[:notice] = "Category #{@category.name} deleted"
    redirect_to categories_path
  end

  private

  def params_have_valid_user_id
    category_params[:user_id] == current_user.id.to_s
  end

  def create_category
    @category.save
    flash[:notice] = 'Category created'
    redirect_to @category
  end

  def handle_category_validation_failed
      flash[:errors] = @category.errors.full_messages
      redirect_back(fallback_location: root_path)
  end

  def fetch_category
    @category = Category.find(params[:id])
  end

  def category_params
    # tylko zapisze name
    params.require(:category).permit(:name)
  end

end
