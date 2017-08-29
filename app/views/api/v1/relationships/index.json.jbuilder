json.array! @relationships.each do |relationship|
  json.id relationship.id
  json.name relationship.connection.name
  json.connection relationship.connection
  json.next_step relationship.step.title
  json.status relationship.connection_status
end