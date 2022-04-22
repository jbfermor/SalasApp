json.extract! reservation, :id, :day, :hour, :title, :description, :tools, :others, :user_id, :room_id, :tech_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
