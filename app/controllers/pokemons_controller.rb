class PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.all
    end

    def show
        find_pokemon
    end

    def new
        @pokemon = Pokemon.new
        @types = Type.all
    end

    def create
        @pokemon = Pokemon.new(pokemon_params)

        if @pokemon.save
            redirect_to pokemon_path(@pokemon)
        else
            render :new
        end
    end

    def edit
        find_pokemon
        @types = Type.all
    end

    def update
        find_pokemon
        @pokemon.update(pokemon_params)
        if @pokemon.save
            redirect_to pokemon_path(@pokemon)
        else
            render :edit
        end
    end

    def destroy
        find_pokemon
        if @pokemon.destroy
            redirect_to pokemons_path
        else
            redirect_to pokemon_path(@pokemon)
        end
    end

    private

    def pokemon_params
        params.require(:pokemon).permit(:name, :type_ids => [])
    end

    def find_pokemon
        @pokemon = Pokemon.find_by(id: params[:id])
    end
    
end
