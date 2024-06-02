class Photo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :image, presence: true
end
