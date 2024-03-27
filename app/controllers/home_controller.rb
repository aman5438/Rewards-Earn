class HomeController < ApplicationController
  include Devise::Controllers::Helpers

  def index
    @sorted_users_with_ranks = User.order(:rank).select("id, total_points, username, total_points, rank, country_code ").limit(100)
  end

  def update_youtube_stream_count
    current_user.user_actions.find_or_create_by(action_id: Action.find_by_name("OnYouTubeView").id, status: "completed")
  end

  def quest
    @user_actions = current_user.actions.group(:name, :points).count
    @social_media_actions = UserAction.social_media_actions(current_user.id)
  end

  def add_post_link
    current_user.user_actions.create(status: "pending", meta: params["post_url"]) if params["post_url"].present?
    redirect_to quest_path
  end

  def download
    filename = params[:filename]
    extention = params[:format]
    send_file Rails.root.join('app', 'assets', 'images', "#{filename}.#{extention}"), disposition: 'attachment'
  end

  def create
    user = User.find_by(email: params["user"]["email"])
    if user && user.valid_password?(params["user"]["password"])
      session[:user_id] = user.id
      redirect_to dashboard_home_index_path
    else
      flash[:error] = 'Invalid email or password'
      redirect_to root_path
    end 
  end

  def destroy
    session.delete(:user_id)
    session.delete("warden.user.user.key")
    redirect_to root_path
  end

  def profile
    @user = current_user
  end

  def update_profile
    if current_user&.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to dashboard_home_index_path
    end
  end

  def dashboard
    @sorted_users_with_ranks = [current_user] + User.where.not(id: current_user.id).order(:rank).select("id, total_points, username, total_points, rank, country_code ").limit(99)
  end

  private

   def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :birth_year, :country_code, :email)
   end

end