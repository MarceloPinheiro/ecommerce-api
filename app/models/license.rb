class License < ApplicationRecord
  belongs_to :game

  validates :key, presence: true
end
