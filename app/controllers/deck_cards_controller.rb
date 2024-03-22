class DeckCardsController < ApplicationController
    before_action :set_deck_cards, only:[:show, :update, :destroy]
    before_action :set_deck, only:[:show, :update, :destroy]

    def index 
        if deck_cards = @deck.deck_cards
            render json: deck_cards.includes(:card), status: :ok
        else 
            render json: { message: 'Cards not found in deck.'}, status: :not_found
        end
    end

    def show
        if @deck_cards
            render json: @deck_cards.includes(:card), status: :ok
        else
            render json:{message: 'Card not found in deck.'}, status: :not_found
        end
    end

    def create
        deck_cards = @deck.deck_cards.new(deck_cards_params)
        if deck_cards.save
            render json: deck_cards.includes(:card), notice: "Card added to deck."
        else 
            render json: deck_cards.errors, status: :unprocessable_entity
        end
    end

    def update
        card = Card.find(params[:card_id])
        if @deck.deck_cards.update(card)
            render json: @deck.deck_cards, notice: "deck_cards updated."
        else 
            render json: deck.deck_cards.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @deck_cards.destroy
            head :no_content, notice: "Card removed from deck_cards."
        else
            render json: @deck_cards.errors, status: :unprocessable_entity
        end
    end

    private

    def deck_cards_params
        params.require(:deck_cards).permit(params[:deck_id, :card_id, :quantity])
    end

    def set_deck
        @deck = Deck.find(params[:deck_id])
        if @deck != current_user
            render json: { message: 'Unauthorized access.'}, status: :unauthorized
        end
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'Deck not found.' }, status: :not_found
    end

    def set_deck_cards
        @deck_cards = @deck.deck_cards.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Card not found in deck.' }, status: :not_found
    end
end
