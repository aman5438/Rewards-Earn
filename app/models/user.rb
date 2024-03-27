class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :invitations, class_name: 'Invitation', foreign_key: 'inviter_id', dependent: :destroy
  has_many :rewards, dependent: :destroy

  has_many :user_actions
  has_many :actions, through: :user_actions

  after_create_commit :send_welcome_email
  after_create_commit :user_reward_create
  before_create :generate_username
  after_save :recalculate_ranks, if: :saved_change_to_total_points?

  def rewards_action
    self.user_actions.create(action_id: Action.find_by_name("OnEmailInviteAccepted").id, meta: email, status: "accepted")
  end

  def recalculate_ranks
    User.calculate_ranks
  end
 
  def name
    first_name + " " + last_name
  end

  def self.calculate_ranks
    sql_query = <<-SQL
      SELECT
        id,
        RANK() OVER (ORDER BY total_points DESC) AS rank
      FROM
        users
    SQL
    ranks_result = ActiveRecord::Base.connection.execute(sql_query)
    user_ranks = {}

    ranks_result.each do |row|
      user_ranks[row['id']] = row['rank']
    end
    users_to_update = User.where(id: user_ranks.keys)

    users_to_update.each do |user|
      user.update(rank: user_ranks[user.id])
    end
  end


  private
    def user_reward_create
      self.user_actions.find_or_create_by(action_id: Action.find_by_name("OnSignUp").id, meta: email, status: "completed")
    end

    def send_welcome_email
      WelcomeMailer.mailer(self.id).deliver_now
    end

    def generate_username
      self.username = "spaceman-" + (self.first_name[0].presence || 'r').downcase + (last_name[0].presence || 'z').downcase + SecureRandom.hex(4)
    end
end
