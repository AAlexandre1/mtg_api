class KeywordsController < ApplicationController
    before_action :set_keyword, only:[:show, :update, :destroy]

    def index
        keywords = Keyword.all
        if keywords != []
            render json: keywords, status: :ok
        else 
            render json:{message: 'Keywords not found.'}, status: :not_found
        end
    end

    def show
        if @keyword
            render json: @keyword, status: :ok
        else
            render json:{message: 'Keyword not found.'}, status: :not_found
        end
    end

    def create
        keyword = Keyword.new(keyword_params)
        if keyword.save
            render json: keyword, status: :created
        else
            render json: keyword.errors, status: :unprocessable_entity
        end
    end

    def update
        if @keyword.update(keyword_params)
            render json: @keyword, status: :ok
        else
            render json: @keyword.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @keyword.destroy
            render json: {message: "Keyword deleted."}, head: :no_content
        else
            render json: @keyword.errors, status: :unprocessable_entity
        end
    end


    private

    def keyword_params
        params.require(:keyword).permit(:name)
    end

    def set_keyword
        @keyword = Keyword.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Keyword entry not found.' }, status: :not_found
    end
end
