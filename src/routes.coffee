# routes

apiClient = require './api-client'

module.exports = (match) ->
  match "/", (callback) ->
    console.log "index"

    callback null, "index"

  match "/posts", (callback) ->
    console.log "posts"

    apiClient.get "/posts.json", (err, res) ->
      return callback err if err

      posts = res.body
      callback null, "posts", {posts}

  match "/posts/:id", (id, callback) ->
    console.log "post: #{id}"

    apiClient.get "/posts/#{id}.json", (err, res) ->
      return callback err if err

      post = res.body
      callback null, "post", post
