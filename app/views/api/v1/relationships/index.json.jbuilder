json.array! @relationships.each do |relationship|
  json.id relationship.id
  json.connection relationship.connection
  json.name relationship.connection.name
  json.next_step relationship.step.title
  json.inverse_status relationship.connection_status
  json.connected_status relationship.connected_status
  json.user_status relationship.user_status
  json.step relationship.step
end