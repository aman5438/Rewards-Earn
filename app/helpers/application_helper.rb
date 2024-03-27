module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end
  
  def alert_bar_type(key)
    case key
    when 'success'
      'success'
    when 'warning'
      'warning'
    when 'info'
      'info'
    when 'danger', 'error'
      'danger'
    else
      'info'
    end
  end

  def valid_flash_msg key
    ['danger', 'info', 'success', 'alert', 'warning', 'error'].include? key
  end

  def format_european_billion(number)
    # Convert the number to a string with leading zeros using sprintf
    padded_number = sprintf("%010d", number)

    # Format the padded number with delimiters using number_with_delimiter
    formatted_number = number_with_delimiter(padded_number, delimiter: ' ', separator: ',')

    # Return the formatted number
    formatted_number
  end

  def find_key_in_hash(hash_data, has_key_to_find)
    hash_data.find { |key, _| key.first == has_key_to_find }
  end

  def points(data)
    points_data = [
        {
          name: "InviteFriendsByEmail",
          points: 10,
          description: "Share invitation to friends by email (unlimited but an email-address will only register 1 time)",
          invitations: "",
          points_gained: "",
          button: "Invite more",
          link: "",
          object_name: "Invitations"
        },
        {
          name: "OnEmailInviteAccepted",
          points: 100,
          description: "When one of your invitees registers for the Spaceman Challenge",
          invitations: "",
          points_gained: "",
          object_name: "Registrations"
        },
        {
          name: "OnSharingMeme",
          points: 200,
          description: 'Sharing the "Spaceman Challenge" memes in social media',
          invitations: "",
          points_gained: "",
          button: "Share more",
          link: "",
          object_name: "Shares"
        },
        {
          name: "OnYouTubeComment",
          points: 500,
          description: 'For each comment on "Spaceman - Lyric Video" on YouTube with your Spaceman Challenge username',
          invitations: "",
          points_gained: "",
          object_name: "Comments"
        },
        {
          name: "OnYouTubeView",
          points: 1000,
          description: "For each complete YouTube view",
          invitations: "",
          points_gained: "",
          button: "Watch video",
          link: "watch_youtube_video",
          object_name: "View"
        },
        {
          name: "Glimpse",
          points: 2500,
          description: "Catch a glimpse of us on tour and scan the QR-code on our tour bus",
          invitations: "",
          points_gained: "",
          object_name: "Scan"
        },
        {
          name: "ScanQRCode",
          points: 5000,
          description: 'Come to our show and scan the QR-code at the merch booth',
          invitations: "",
          points_gained: "",
          object_name: "Scan"
        },
        {
          name: "OnOwnVideoSharing",
          points: 10000,
          description: 'Make your own "Spaceman Challenge"-video and post in social media; do anything funny while in an astronaut- or alien-costume, and link the song in the clip and tagging @supremeunbeing',
          invitations: "",
          points_gained: "",
          object_name: "Videos"
        }
      ]
     transformed_data = []
     points_data.each do |point|
      data_key = data.keys.find { |key| key.first == point[:name] }
      invitations = data_key ? data[data_key] : 0
      points_gained = invitations * point[:points]
      transformed_data << point.merge(invitations: invitations, points_gained: points_gained)
    end
    return transformed_data
  end
end
