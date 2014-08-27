json.array! @tweets do |tweet|
  json.(tweet, :id, :content, :created_at, :user)
  # ^- short for this -v
  # json.id         tweet.id
  # json.content    tweet.content
  # json.created_at tweet.created_at
  # json.user       tweet.user
end
