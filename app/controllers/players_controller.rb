class PlayersController < ApplicationController
    before_action :set_player, only:[:show, :update, :destroy]

    def index
        players = Player.all
        if players != []
            render json: players, status: :ok
        else
            render json: { message: 'Players not found.' }, status: :not_found
        end
    end

    def show
        if @player
            render json: @player, status: :ok
        else
            render json:{message: 'Player not found.'}, status: :not_found
        end
    end

    def create
        player = Player.new(player_params)
        if player.save
            render json: player, status: :created
        else
            render json: player.errors, status: :unprocessable_entity
        end
    end

    def update
        if @player.update(player_params)
            render json: @player, status: :ok
        else
            render json: @player.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @player.destroy
            head :no_content
        else
            render json: @player.errors, status: :unprocessable_entity
        end
    end

    # def libraries
    #     @libraries = @player.libraries.includes(:card)
    # end

    # def wishlists
    #     @wishlists = @player.wishlists.includes(:card)
    # end

    # def decks
    #     @decks = @player.decks.includes(:card)
    # end


    private

    def player_params
        params.require(:player).permit(:username)
    end

    def set_player
        @player = Player.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Player not found.' }, status: :not_found
    end
end
