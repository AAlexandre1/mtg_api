class LibrariesController < ApplicationController
    before_action :set_player, only:[:index, :show, :update, :destroy]
    before_action :set_library, only:[:show, :update, :destroy]

    def index
        libraries = @player.libraries.includes(:card)
        if libraries != []
            render json: libraries, include: :card, status: :ok
        else 
            render json: { message: 'Libraries not found.'}, status: :not_found
        end
    end

    def show
        if @library
            render json: @library, include: :card, status: :ok
        else
            render json:{message: 'Library entry not found.'}, status: :not_found
        end
    end

    def create
        library = Library.new(library_params)
        if library.save
            render json: library, include: :card, notice: "Card added to library."
        else 
            render json: library.errors, status: :unprocessable_entity
        end
    end

    def update
        if @library.update(library_params)
            render json: @library, include: :card, notice: "Library updated."
        else
            render json: @library.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @library.destroy
            render json: { message: "Library entry deleted." }, head: :no_content, notice: "Card removed from library."
        else
            render json: @library.errors, status: :unprocessable_entity
        end
    end

    private

    def library_params
        params.require(:library).permit(:player_id, :card_id, :quantity)
    end

    def set_player
        @player = Player.find(params[:player_id])
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'Player not found.' }, status: :not_found
    end

    def set_library
        @library = @player.libraries.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Library entry not found.' }, status: :not_found
    end
    
end
