class WishlistsController < ApplicationController
    before_action :set_player, :set_wishlist

    def index 
        if wishlists = @player.wishlists
            render json: wishlists.includes(:card), status: :ok
        else 
            render json: { message: 'Wishlist not found.'}, status: :not_found
        end
    end

    def show
        if @wishlist
            render json: @wishlist.includes(:card), status: :ok
        else
            render json:{message: 'Wishlist entry not found.'}, status: :not_found
        end
    end

    def create
        wishlist = @player.wishlist.new(wishlist_params)
        if wishlist.save
            render json: wishlist.includes(:card), notice: "Card added to wishlist."
        else 
            render json: wishlist.errors, status: :unprocessable_entity
        end
    end

    def update
        card = Card.find(params[:card_id])
        if @player.wishlist.update(card)
            render json: @player.wishlist, notice: "wishlist updated."
        else 
            render json: player.wishlist.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @wishlist.destroy
            head :no_content, notice: "Card removed from wishlist."
        else
            render json: @wishlist.errors, status: :unprocessable_entity
        end
    end

    private

    def wishlist_params
        params.require(:wishlist).permit(params[:player_id, :card_id, :quantity])
    end

    def set_player
        @player = Player.find(params[:player_id])
        if @player != current_user
            render json: { message: 'Unauthorized access.'}, status: :unauthorized
        end
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'Player not found.' }, status: :not_found
    end

    def set_wishlist
        @wishlist = @player.wishlist.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Wishlist entry not found.' }, status: :not_found
    end
end
