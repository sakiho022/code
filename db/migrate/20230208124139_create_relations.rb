class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :relations do |t|
      t.integer :keyword_id
      t.integer :category_id

      t.timestamps
    end
  end
end

class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.timestamps
    end

    create_table :categories do |t|
      t.string :category_name
      t.timestamps
    end

    create_table :relations do |t|
      t.belongs_to :keyword
      t.belongs_to :category
      t.datetime :relation_date
      t.timestamps
    end
  end
end