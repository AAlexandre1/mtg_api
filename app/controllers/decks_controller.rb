class DecksController < ApplicationController
    before_action :set_deck, only:[:show, :update, :destroy]
    before_action :set_player, only:[:create, :index]

    nested do
        resources :deck_cards, only: [:index, :show, :create, :destroy, :update]
    end
    

    def index
        decks = @player.decks
        if decks
            render json: decks, status: :ok
        else
            render json:{message: 'decks not found.'}, status: :not_found
        end
    end
    
    def show
        if @deck
            render json: @deck, including: [:cards], status: :ok
        else
            render json: { message: 'Deck not found.' }, status: :not_found
        end
    end
    
    def create
        deck = @player.decks.new(deck_params)
        if deck.save
            render json: deck, status: :created
        else
            render json: deck.errors, status: :unprocessable_entity
        end
    end

    def update
        if @deck.update(deck_params)
            render json: deck, status: :ok
        else
            render json: deck.errors, status: :unprocessable_entity
        end
    end
    
    def destroy
        if @deck.destroy
            head :no_content
        else
            render json: @deck.errors, status: :unprocessable_entity
        end
    end

    def add_card
        card = Card.find(params[:card_id]) rescue nil
        if !card
            render json: { message: 'Card not found.' }, status: :not_found
            return
        end
    
        # quantity = params[:quantity].to_i
        # if quantity <= 0
        #     render json: { message: 'Invalid quantity.' }, status: :unprocessable_entity
        #     return
        # end
    
        deck_card = @deck.deck_cards.create(card: card, quantity: quantity)
    
        if deck_card.save
            render json: deck_card, including: [:card], status: :created
        else
            render json: deck_card.errors, status: :unprocessable_entity
        end
    end

    private 

    def deck_params
        params.require(:deck).permit(:name, :description)
    end

    def set_deck
        @deck = Deck.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Deck not found.' }, status: :not_found
    end

    def set_player
        @player = Player.find(params[:player_id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Player not found.' }, status: :not_found
    end
end
