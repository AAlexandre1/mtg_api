class TypesController < ApplicationController
    before_action :set_type, only:[:show, :update, :destroy]

    def index
        types = Type.all
        if types != []
            render json: types, status: :ok
        else 
            render json:{message: 'Types not found.'}, status: :not_found
        end
    end

    def show
        if @type
            render json: @type, status: :ok
        else
            render json:{message: 'Type not found.'}, status: :not_found
        end
    end

    def create
        type = Type.new(type_params)
        if type.save
            render json: type, status: :created
        else
            render json: type.errors, status: :unprocessable_entity
        end
    end

    def update
        if @type.update(type_params)
            render json: @type, status: :ok
        else
            render json: @type.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @type.destroy
            render json: {message: "Type deleted."}, head: :no_content
        else
            render json: @type.errors, status: :unprocessable_entity
        end
    end


    private

    def type_params
        params.require(:type).permit(:name)
    end

    def set_type
        @type = Type.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Type entry not found.' }, status: :not_found
    end
end
