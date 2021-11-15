class ArticleController < ApplicationController

    def index

        article = Article.all

        render json: article

    end

    def new

    end

    def show

    end

    def edit


    end

    def update

    end

end
