class Mana < ApplicationRecord
    validates :name, presence: :true, uniqueness: :true
end
