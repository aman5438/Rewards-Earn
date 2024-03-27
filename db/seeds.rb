# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

actions = [
  { name: 'InviteFriendsByEmail', points: 10 },
  { name: 'OnSignUp', points: 10 },
  { name: 'OnEmailInviteAccepted', points: 100 },
  { name: 'OnSharingMeme', points: 200 },
  { name: 'OnYouTubeComment', points: 500 },
  { name: 'OnYouTubeView', points: 1000 },
  { name: 'OnOwnVideoSharing', points: 10000 },
]

actions.each do |action_params|
  Action.find_or_create_by(name: action_params[:name]) do |action|
    action.points = action_params[:points]
  end
end