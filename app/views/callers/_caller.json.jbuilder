json.extract! caller, :id, :name, :original_title, :notes, :created_at, :updated_at
json.url caller_url(caller, format: :json)
