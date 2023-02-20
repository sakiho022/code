class Category < ApplicationRecord
    has_many :relations,dependent: :destroy
    has_many :keywords, through: :relations
  end