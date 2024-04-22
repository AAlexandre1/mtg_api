class CardsController < ApplicationController
    before_action :set_card, only:[:show, :update, :destroy]

    def index
        cards = Card.all
        if cards != []
        # render json: CardBlueprinter.render(cards, view: :normal)
        render json: cards, include: [:mana_costs, :types], :except => [:created_at, :updated_at], status: :ok
    else
            render json:{message: 'Cards not found.'}, status: :not_found
        end
    end

    def show
        if @card 
            # render json: CardBlueprinter.render(@card, view: :extended), status: :ok
            render json: cards, include: [:mana_costs, :card_types], :except => [:created_at, :updated_at], status: :ok
        else
            render json:{message: 'Card not found.'}, status: :not_found
        end
    end

    def create
        card = Card.new(card_params)
        if card.save!
            card_id = card.id
            card_type = card.card_types.new(card_type_params.merge(card_id: card_id))
            if card_type.save
        #     params[:mana_costs].each do |mana_cost|
        #     mana_cost = card.mana_costs.new(mana_cost)
        #     if mana_cost.save
        #         render json: mana_cost.errors, status: :unprocessable_entity
        #         break
        #     end
        # end
        #     render json: card, include: :mana_costs, status: :ok
        # else
                render json: card, include: [:card_types], :except => [:created_at, :updated_at], status: :ok
            else
                render json: card.errors, status: :unprocessable_entity
            end
        end
    end
                # render json: CardBlueprinter.render(card, view: :extended), status: :created


    def update
        if @card.update(card_params)
            # if params[:mana_cost]
            #     mana_cost = @card.mana_costs.find_or_create_by(mana_cost_params)
            #     if @mana_cost.update(mana_cost_params)
            #         render json: @card, include: :mana_costs, status: :ok
            #     else
            #         render json: @mana_costs.errors, status: :unprocessable_entity
            #     end
            # else
            #     render json: @card, include: :mana_costs, status: :ok
            # end
            render json: cards, include: [:mana_costs, :type_ids, :keyword_ids], :except => [:created_at, :updated_at], status: :ok
        else
            render json: @card.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @card.destroy
            render json: {message: "Card deleted."}, head: :no_content
            if @mana_cost.destroy
                render json: {message: "Mana cost deleted."}, head: :no_content
            else
                render json: @mana_cost.errors, status: :unprocessable_entity
            end
        else
            render json: @card.errors, status: :unprocessable_entity
        end
    end

    # def create_mana_cost
    #     mana_cost = @card.mana_costs.create(mana_cost_params)
    #     if mana_cost.save
    #         render json: mana_cost, status: :created
    #     else
    #         render json: mana_cost.errors, status: :unprocessable_entity
    #     end
    # end

    # def update_mana_cost
    #     if @mana_cost.update(mana_cost_params)
    #         render json: @mana_cost, status: :ok
    #     else
    #         render json: @mana_cost.errors, status: :unprocessable_entity
    #     end
    # end

    # def destroy_mana_cost
    #     if @mana_cost.destroy
    #         head :no_content
    #     else
    #         render json: @mana_cost.errors, status: :unprocessable_entity
    #     end
    # end


    private

    def card_params
        params.require(:card).permit(:name, :set, :power, :toughness, :description, **:card_type_id => {})
        # , :type_cards => [],  :mana_costs => []
    end

    def card_type_params
        params.require(:type).permit(:type_id)
    end

    def mana_cost_params
        params.require(:mana_cost).permit(:mana_id, :quantity)
    end

    def set_card
        @card = Card.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Card not found.' }, status: :not_found
    end

    # def set_mana_cost
    #     @mana_cost = ManaCost.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #     render json: { message: 'Mana cost not found.' }, status: :not_found
    # end
end
