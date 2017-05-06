class CategoriesController < ApplicationController

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
  def show
  	@category = Category.find(params[:id])
  end

  def edit
  	@category = Category.find(params[:id])
  end

  def update
  	@category = Category.find(params[:id])
  	@category.update_attributes(category_params)
  	redirect_to @category
  end

  def destroy
  	@category = Category.find(params[:id])
  	@category.destroy!
  	flash[:notice] = "Category #{@category.name} deleted"
  	redirect_to categories_path
  end

  private

  def category_params
  	# tylko zapisze name
  	params.require(:category).permit(:name)
  end

end