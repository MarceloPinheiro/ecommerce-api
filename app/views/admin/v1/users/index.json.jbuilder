json.users do
    json.array! @loading_service.records, :id, :name, :profile
end