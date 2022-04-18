json.extract! user, :id, :name, :address, :city, :pc, :province, :phone, :email2, :role_id, :created_at, :updated_at
json.url user_url(user, format: :json)
