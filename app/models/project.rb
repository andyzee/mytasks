class Project < ApplicationRecord
  has_many :todos, -> { order("created_at ASC") }

  validates :title, presence: true
  accepts_nested_attributes_for :todos
end
