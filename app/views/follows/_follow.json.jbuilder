json.extract! follow, :id, :follower_user_id, :followee_user_id, :created_at, :updated_at
json.url follow_url(follow, format: :json)
