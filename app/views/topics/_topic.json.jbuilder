json.extract! topic, :id, :topic_name, :created_at, :updated_at
json.post_url topic_url(topic, format: :json)
  