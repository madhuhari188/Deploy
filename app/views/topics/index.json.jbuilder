# json.array! @topics, partial: "topics/topic", as: :topic
json.array! @topics, :id,:topic_name,:created_at,:updated_at
json.array! @topics do |topic|
  json.set! :id, topic.id
  json.topic topic.topic_name
  json.createdAt topic.created_at
  json.updatedAt topic.updated_at
  json.topic_url topic_url(topic, format: :json)
end