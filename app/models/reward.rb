class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :source, polymorphic: true
end
