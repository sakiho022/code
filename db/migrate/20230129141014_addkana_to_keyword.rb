class AddkanaToKeyword < ActiveRecord::Migration[7.0]
  def change
    add_column :keywords, :kana, :text
  end
end
