# api server

_ = require 'underscore'

posts = [
  {
    id: 1
    title: "How to build an isomorphic app."
    author: "spike"
    body: "It's really not that hard!"
    created_at: "2013-11-05T13:56:15.034Z"
  }
  {
    id: 2
    title: "Why JavaScript is eating the world."
    author: "spike"
    body: "It's the lingua franca of the web."
    created_at: "2013-11-04T17:23:01.329Z"
  }
  {
    id: 3
    title: "How to use React effectively."
    author: "couch"
    body: "One way data flows and intelligent routing."
    created_at: "2014-05-30T00:23:42.742Z"
  }
]

module.exports = (app) ->
  app.get "/api/posts.json", (req, res) ->
    console.log "getting posts"
    res.send posts

  app.get "/api/posts/:id.json", (req, res) ->
    id = parseInt req.params.id, 10
    post = _.find posts, (p) -> p.id is id
    if post
      res.send post
    else
      res.send 404
