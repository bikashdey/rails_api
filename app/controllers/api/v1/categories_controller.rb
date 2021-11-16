class Api::V1::CategoriesController < ApplicationController

    def index

        categories = Category.all

        render json: {categories: categories}

    end

    def create
     
        category = Category.new(category_params)
        category.save
        render json: {message: "category created successfully.."}
    end



    def show

        category = Category.find(params[:id])

        render json: category

    end
  

    def update
    
        category = Category.find(params[:id])
        category.article_name = params[:category][:article_name]
       
        if category.save
            render json: category
        else

            render json: { status: 400 , message: "Category updated successfully" }
        end 

    end

    def destroy
        category = Category.find(params[:id])
        category.destroy

        render json: {status: 200 , message: "Category destroyed successfully.."}
    end

    private

    
    def category_params
        params.require(:category).permit(:category_name)
    end

end
