json.extract! recording, :id, :caller_id, :call_date, :recording_folder, :copied_to_mp3, :created_at, :updated_at
json.url recording_url(recording, format: :json)
