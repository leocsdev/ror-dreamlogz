# frozen_string_literal: true

class CreateDreams < ActiveRecord::Migration[7.0]
  def change
    create_table :dreams do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :slug

      t.timestamps
    end
  end
end
