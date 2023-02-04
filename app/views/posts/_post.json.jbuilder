json.extract! post, :id, :title, :body, :created_at, :updated_at
json.url posts_url(post, format: :json)
