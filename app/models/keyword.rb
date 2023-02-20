
class Keyword < ApplicationRecord
    has_many :relations,dependent: :destroy
    has_many :categories, through: :relations
    validates :content,{presence:true,length:{maximum:100},uniqueness:{scope: :kana}}
    
  end
  
