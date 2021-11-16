class Api::V1::ArticlesController < ApplicationController

    def index

        articles = Article.all

        render json: articles

    end

    def create
     
        article = Article.new(article_params)
        article.save

    end



    def show

        article = Article.find(params[:id])

        render json: article

    end
  

    def update
    
        article = Article.find(params[:id])
        article.article_name = params[:article][:article_name]
        article.article_description = params[:article][:article_description]

        if article.save
            render json: article
        else

            render json: { status: 400 }
        end 

    end

    def destroy
        article = Article.find(params[:id])
        article.destroy

        render json: {status: 200 , message: "article destroyed successfully.."}
    end

    private

    
    def article_params
        params.require(:article).permit(:article_name, :article_description)
    end

end
