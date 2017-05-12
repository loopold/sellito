class CategoriesController < ApplicationController
  before_action :fetch_category, only: [:show, :edit, :update, :destroy]

  def index
  	# binding.pry
  	@categories = Category.all
  end

  def new
  	@category = Category.new
  end
 
  def create
  	# narzedzie do debugowania
  	# binding.pry
  	# potem w konsoli mozesz np. params 
  	#  
  	# raise params.to_yaml
  	# Category.create(category_params)
  	@category = Category.new(category_params)
  	if @category.save
	  	flash[:notice] = 'Category created'
	  	# redirect_back(fallback_location: root_path)
	  	# przekierowanie gdzies
	  	redirect_to @category
	  else
	  	flash[:alert] = 'Category not created'
	  	redirect_back(fallback_location: root_path)
		end
  end

  # metody ktore nic nie robia w jednej linijce
  # def show; end
  def show; end

  def edit; end

  def update
    @category.update_attributes(category_params)
    redirect_to @category
  end

  def destroy
    @category.destroy!
    flash[:notice] = "Category #{@category.name} deleted"
    redirect_to categories_path
  end

  private

  def fetch_category
  	@category = Category.find(params[:id])
  end

  def category_params
  	# tylko zapisze name
  	params.require(:category).permit(:name)
  end

end