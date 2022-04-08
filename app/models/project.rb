class Project < ApplicationRecord
  has_many :todos

  validates :title, presence: true
  accepts_nested_attributes_for :todos
end
