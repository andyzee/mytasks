class Project < ApplicationRecord
  has_many :todos, dependent: :delete_all

  validates :title, presence: true
  accepts_nested_attributes_for :todos
end
