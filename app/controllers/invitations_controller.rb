class InvitationsController < ApplicationController

  def share
    params['emails'].each do |email|
      current_user.user_actions.find_or_create_by(action_id: Action.find_by_name("InviteFriendsByEmail").id, meta: email, status: "completed")
      InvitationMailer.send_email(current_user.id, email).deliver_now
    end
  end

  def earn_point
    if params["inviter_id"].present?
      invitation = Invitation.find_by(inviter_id: params["inviter_id"])
      if invitation.present?
        reward = invitation.reward_earn
        render 'home/_sign_up'
      else
        flash[:error] = "Invalid invitation id"
        destroy
        redirect_to root_path
      end
    end
  end
end