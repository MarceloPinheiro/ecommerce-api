json.users do
    json.array! @users, :id, :name, :profile
end