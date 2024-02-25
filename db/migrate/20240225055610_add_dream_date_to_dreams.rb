# frozen_string_literal: true

class AddDreamDateToDreams < ActiveRecord::Migration[7.0]
  def up
    add_column :dreams, :dream_date, :datetime, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  def down
    remove_column :dreams, :dream_date
  end
end
