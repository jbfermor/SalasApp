json.extract! user, :id, :nif, :name, :surname1, :surname2, :address, :pc, :city, :province, :phone1, :phone2, :email2, :suscriptor, :created_at, :updated_at
json.url user_url(user, format: :json)
