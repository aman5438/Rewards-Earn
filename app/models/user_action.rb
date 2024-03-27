class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :action, optional: true

  after_create_commit :update_user_total_points, if: -> {saved_change_to_status? || new_record? }

  scope :social_media_actions, -> (user_id) do
    where(action_id: nil)
      .or(where(action_id: Action.where(name: ["OnSharingMeme", "OnOwnVideoSharing"]).pluck(:id)))
      .where(user_id: user_id)
  end

  def update_user_total_points
    user.update(total_points: user.actions.sum(:points))
  end
end