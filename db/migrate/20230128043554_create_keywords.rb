class CreateKeywords < ActiveRecord::Migration[7.0]
  def change

    add_index: users,[:name,:kana],unique true
    create_table :keywords do |t|
      t.text :content
      t.timestamps
    end
  end
end
