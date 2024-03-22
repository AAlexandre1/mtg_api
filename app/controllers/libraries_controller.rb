class LibrariesController < ApplicationController
    before_action :set_library, only:[:show, :update, :destroy]
    before_action :set_player, only:[:show, :update, :destroy]

    def index 
        if libraries = @player.libraries
            render json: libraries.includes(:card), status: :ok
        else 
            render json: { message: 'Library not found.'}, status: :not_found
        end
    end

    def show
        if @library
            render json: @library.includes(:card), status: :ok
        else
            render json:{message: 'Library entry not found.'}, status: :not_found
        end
    end

    def create
        library = @player.library.new(library_params)
        if library.save
            render json: library.includes(:card), notice: "Card added to library."
        else 
            render json: library.errors, status: :unprocessable_entity
        end
    end

    def update
        card = Card.find(params[:card_id])
        if @player.library.update(card)
            render json: @player.library, notice: "Library updated."
        else 
            render json: player.library.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @library.destroy
            head :no_content, notice: "Card removed from library."
        else
            render json: @library.errors, status: :unprocessable_entity
        end
    end

    private

    def library_params
        params.require(:library).permit(params[:player_id, :card_id, :quantity])
    end

    def set_player
        @player = Player.find(params[:player_id])
        if @player != current_user
            render json: { message: 'Unauthorized access.'}, status: :unauthorized
        end
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'Player not found.' }, status: :not_found
    end

    def set_library
        @library = @player.library.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Library entry not found.' }, status: :not_found
    end
    
end
