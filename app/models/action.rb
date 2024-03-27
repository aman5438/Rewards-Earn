class Action < ApplicationRecord
  has_many :user_actions
  has_many :users, through: :user_actions
end
