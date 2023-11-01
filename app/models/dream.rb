# == Schema Information
#
# Table name: dreams
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  slug       :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Dream < ApplicationRecord
  validates :title, :body, presence: true
end
