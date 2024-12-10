json.extract! user, :id, :fname, :lname, :email, :password, :is_admin, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
