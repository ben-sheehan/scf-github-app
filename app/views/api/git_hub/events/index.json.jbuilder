json.events do
  json.array! @resources[:events] do |event|
    json.(event, :type, :actor, :created_at)
  end
end
