# frozen_string_literal: true

# == Schema Information
#
# Table name: dreams
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  dream_date :datetime         not null
#  slug       :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Dream < ApplicationRecord
  validates :title, :body, presence: true

  # Get all the dreams today
  scope :today, -> { where("DATE(created_at) = ?", Date.current).order("created_at desc") }
end
