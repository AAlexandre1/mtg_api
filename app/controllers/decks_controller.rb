class DecksController < ApplicationController
    before_action :set_player, only:[:index, :show, :update, :destroy]
    before_action :set_deck, only:[:show, :update, :destroy]

    def index
        decks = @player.decks.includes(:deck_cards)
        if decks != []
            render json: decks, include: :deck_cards, status: :ok
        else
            render json:{message: 'Decks not found.'}, status: :not_found
        end
    end
    
    def show
        if @deck
            render json: @deck, include: :deck_cards, status: :ok
        else
            render json: { message: 'Deck not found.' }, status: :not_found
        end
    end
    
    def create
        deck = Deck.new(deck_params)
        if deck.save
            render json: deck, status: :created
        else
            render json: deck.errors, status: :unprocessable_entity
        end
    end

    def update
        if @deck.update(deck_params)
            render json: @deck, include: :deck_cards, status: :ok, notice: "Library updated."
        else
            render json: @deck.errors, status: :unprocessable_entity, notice: "Library not found."
        end
    end
    
    def destroy
        if @deck.destroy
            @deck.deck_cards.destroy
            render json: { message: "Deck deleted." }, head: :no_content
        else
            render json: @deck.errors, status: :unprocessable_entity
        end
    end

    private 

    def deck_params
        params.require(:deck).permit(:player_id, :name, :description)
    end

    def set_deck
        @deck = @player.decks.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Deck entry not found.' }, status: :not_found
    end

    def set_player
        @player = Player.find(params[:player_id])
        rescue ActiveRecord::RecordNotFound
            render json: { message: 'Player not found.' }, status: :not_found
    end
end

    # def add_card
    #     card = Card.find(params[:card_id]) rescue nil
    #     if !card
    #         render json: { message: 'Card not found.' }, status: :not_found
    #         return
    #     end
    # end
        # quantity = params[:quantity].to_i
        # if quantity <= 0
        #     render json: { message: 'Invalid quantity.' }, status: :unprocessable_entity
        #     return
        # end
    
        # deck_card = @deck.deck_cards.create(card: card, quantity: quantity)
    
    #     if deck_card.save
    #         render json: deck_card, including: [:card], status: :created
    #     else
    #         render json: deck_card.errors, status: :unprocessable_entity
    #     end
    # end
