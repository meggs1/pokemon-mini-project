class TypesController < ApplicationController

    def index
        @types = Type.all
    end

    def show
        find_type
    end

    def new
        @type = Type.new
        @pokemons = Pokemon.all
    end

    def create
        @type = Type.new(type_params)
        if @type.valid?
            @type.save
            redirect_to type_path(@type)
        else
            redirect_to new_view_path
        end
    end

    def edit
        find_type
        @pokemons = Pokemon.all
    end

    def update
        find_type
        @type.update(type_params)
        if @type.save
            redirect_to type_path(@type)
        else
            redirect_to edit_view_path
        end
    end

    def destroy
        find_type
        if @type.destroy
            redirect_to types_path
        else
            redirect_to type_path(@type)
        end
    end

    private

    def type_params
        params.require(:type).permit(:name, :pokemon_ids => [])
    end

    def find_type
        @type = Type.find_by(id: params[:id])
    end
    
end
