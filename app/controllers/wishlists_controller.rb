class WishlistsController < ApplicationController
    before_action :set_player, only:[:index, :show, :update, :destroy]
    before_action :set_wishlist, only:[:index, :show, :update, :destroy]

    def index 
        wishlists = @player.wishlists.includes(:card)
        if wishlists != []
            render json: wishlists, include: :card, status: :ok
        else 
            render json: { message: 'Wishlists not found.'}, status: :not_found
        end
    end

    def show
        if @wishlist
            render json: @wishlist, include: :card, status: :ok
        else
            render json:{message: 'Wishlist entry not found.'}, status: :not_found
        end
    end

    def create
        wishlist = Wishlist.new(wishlist_params)
        if wishlist.save
            render json: wishlist, include: :card, notice: "Card added to wishlist."
        else 
            render json: wishlist.errors, status: :unprocessable_entity
        end
    end

    def update
        if @wishlist.update(wishlist_params)
            render json: @wishlist, include: :card, notice: "Wishlist updated."
        else
            render json: @wishlist.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @wishlist.destroy
            render json: { message: "Wishlist deleted." }, head: :no_content, notice: "Card removed from wishlist."
        else
            render json: @wishlist.errors, status: :unprocessable_entity
        end
    end

    private

    def wishlist_params
        params.require(:wishlist).permit(:player_id, :card_id, :quantity)
    end

    def set_player
        @player = Player.find(params[:player_id])
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'Player not found.' }, status: :not_found
    end

    def set_wishlist
        @wishlist = @player.wishlists.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Wishlist entry not found.' }, status: :not_found
    end
    
end
