class DeckCardsController < ApplicationController
    before_action :set_deck, only:[:index, :show, :update, :destroy]
    before_action :set_deck_card, only:[:index, :show, :update, :destroy]

    def index 
        deck_cards = @deck.deck_cards.includes(:card)
        if deck_cards != []
            render json: deck_cards, include: :card, status: :ok
        else 
            render json: { message: 'Deck cards not found.'}, status: :not_found
        end
    end

    def show
        if @deck_card
            render json: @deck_card, include: :card, status: :ok
        else
            render json:{message: 'Deck card entry not found.'}, status: :not_found
        end
    end

    def create
        deck_card = DeckCard.new(deck_card_params)
        if deck_card.save
            render json: deck_card, include: :card, notice: "Card added to deck card."
        else 
            render json: deck_card.errors, status: :unprocessable_entity
        end
    end

    def update
        if @deck_card.update(deck_card_params)
            render json: @deck_card, include: :card, notice: "deck_card updated."
        else
            render json: @deck_card.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @deck_card.destroy
            render json: { message: "deck_card deleted." }, head: :no_content, notice: "Card removed from deck_card."
        else
            render json: @deck_card.errors, status: :unprocessable_entity
        end
    end

    private

    def deck_card_params
        params.require(:deck_card).permit(:deck_id, :card_id, :quantity)
    end

    def set_deck
        @deck = Deck.find(params[:deck_id])
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'deck not found.' }, status: :not_found
    end

    def set_deck_card
        @deck_card = @deck.deck_cards.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Deck card entry not found.' }, status: :not_found
    end
    
end
