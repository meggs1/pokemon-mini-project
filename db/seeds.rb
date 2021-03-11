require 'rest-client'

def get_types    
    types_list = RestClient.get("https://pokeapi.co/api/v2/type")
    types_array = JSON.parse(types_list)["results"]

    types_array.each do |type|
        type_info = RestClient.get(type["url"])
        type_info_hash = JSON.parse(type_info)
        Type.create(url: type["url"], name: type["name"])
    end
end

def get_pokemon
    pokemon_list = RestClient.get 'https://pokeapi.co/api/v2/pokemon?&limit=151'
    pokemon_array = JSON.parse(pokemon_list)["results"]

    pokemon_array.each do |pokemon|
        pokemon_page = RestClient.get(pokemon["url"])
        pokemon_info = JSON.parse(pokemon_page)

        pokemon = Pokemon.create(name: pokemon["name"], url: pokemon["url"])

        pokemon_info["types"].each do |type|
        type = Type.all.find_by(url: type["type"]["url"])
            if type
                PokemonType.create(pokemon_id: pokemon.id, type_id: type.id )
            end
        end
    end
end

get_types
get_pokemon


puts "Types created: #{Type.count}"
puts "Pokemons created: #{Pokemon.count}"