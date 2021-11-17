class ArticlesController < ApplicationController
    before_action :set_connection

    def index
        byebug
        encrypted_consumer_key

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
   
        article = Article.find_by(params[:id])
        article.article_name = params[:article][:article_name]
        article.article_description = params[:article][:article_description]

        if article.save
            render json: article
        else

            render json: { status: 400 }
        end 

    end

    def destroy
        article = Article.find_by(params[:id])
        article.destroy

        render json: {status: 200 , message: "article destroyed successfully.."}
    end

    private

    
    def article_params
        params.require(:article).permit(:article_name, :article_description)
    end

    def set_connection
        ActiveRecord::Base.clear_active_connections!
        ActiveRecord::Base.establish_connection(
            adapter:  "mysql2",
            host:     "localhost",
            username: "root",
            password: "",
            database: "rails_api_development"
          )
    
    end


    def encrypted_consumer_key
        byebug
        # salt = ENV['SALT'] # We save the value of: SecureRandom.random_bytes(64)
        key = ENV['KEY']   # We save the value of: ActiveSupport::KeyGenerator.new('password').generate_key(salt)
        crypt = ActiveSupport::MessageEncryptor.new(key)
        consumer_key = self.consumer_key # Input value from our form
        encrypted_data = crypt.encrypt_and_sign(consumer_key) # or crypt.encrypt_and_sign(self.consumer_key)
        self.consumer_key = encrypted_data
        # You can refactor to make these steps shorter.
      end

end
