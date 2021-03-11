class Pokemon < ApplicationRecord
    has_many :pokemon_types
    has_many :types, through: :pokemon_types

    validates :name, presence: true, uniqueness: true
end
