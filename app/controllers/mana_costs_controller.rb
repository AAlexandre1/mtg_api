class ManaCostsController < ApplicationController
    require 'debug'
    before_action :set_mana_cost, only: [:show, :update, :destroy]
    before_action :set_card, only: [:show, :update, :destroy]

    def index
        mana_costs = ManaCost.all
        if mana_costs != []
            render json: mana_costs, status: :ok
        else 
            render json:{message: 'Mana Costs not found.'}, status: :not_found
        end
    end

    def show
        if @mana_cost
            render json: @mana_cost, status: :ok
        else
            render json:{message: 'Mana Cost not found.'}, status: :not_found
        end
    end
    
    def create
        # debugger
        mana_cost = ManaCost.create(mana_cost_params)
        if mana_cost.save
            render json: mana_cost, status: :created
        else
            render json: mana_cost.errors, status: :unprocessable_entity
        end
    end

    def update
        mana_cost = mana_costs.update(mana_cost_params)
        if mana_cost.save
            render json: mana_cost, status: :created
        else
            render json: mana_cost.errors, status: :unprocessable_entity
        end
    end

    def destroy
        mana_cost = mana_costs.destroy
        if mana_cost.save
            render json: mana_cost, status: :created
        else
            render json: mana_cost.errors, status: :unprocessable_entity
        end
    end

    private

    def set_mana_cost
        @mana_cost = ManaCost.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        render json: { message: 'Mana cost not found.' }, status: :not_found
    end

    def mana_cost_params
        params.require(:mana_cost).permit(:mana_id, :quantity)
    end

    def set_card
        @card = Card.find(params[:card_id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Card not found.' }, status: :not_found
    end
end
