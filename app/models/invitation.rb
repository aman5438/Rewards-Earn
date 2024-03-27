class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: 'User', foreign_key: 'inviter_id'

  enum status: { pending: 'pending', accepted: 'accepted' }.freeze

  before_create :downcase_email
  before_create :remove_whitespace_from_email

  validates :invitee_email, presence: true,
    format: {
      with: /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/
    }

  def downcase_email
    self.invitee_email = self.invitee_email.downcase
  end

  def remove_whitespace_from_email
    self.invitee_email = self.invitee_email.strip
  end

end