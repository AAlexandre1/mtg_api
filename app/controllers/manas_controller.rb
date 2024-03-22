class ManasController < ApplicationController
    before_action :set_mana, only:[:show, :update, :destroy]

    def index
        manas = Mana.all
        if manas != []
            render json: manas, status: :ok
        else 
            render json:{message: 'Manas not found.'}, status: :not_found
        end
    end

    def show
        if @mana
            render json: @mana, status: :ok
        else
            render json:{message: 'Mana not found.'}, status: :not_found
        end
    end

    def create
        mana = Mana.new(mana_params)
        if mana.save
            render json: mana, status: :created
        else
            render json: mana.errors, status: :unprocessable_entity
        end
    end

    def update
        if @mana.update(mana_params)
            render json: @mana, status: :ok
        else
            render json: @mana.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @mana.destroy
            render json: {message: "Mana deleted."}, head: :no_content
        else
            render json: @mana.errors, status: :unprocessable_entity
        end
    end


    private

    def mana_params
        params.require(:mana).permit(:name)
    end

    def set_mana
        @mana = Mana.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Mana not found.' }, status: :not_found
    end
end
