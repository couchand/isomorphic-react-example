# wrapper around superagent

superagent = require 'superagent'

isServer = typeof window is 'undefined'

port = process.env.PORT or 3030

['get', 'post', 'put', 'path', 'del'].map (method) ->
  module.exports[method] = (path) ->
    args = Array.prototype.slice.call arguments, 1
    args = [formatUrl path].concat args
    console.log args
    superagent[method].apply superagent, args

formatUrl = if isServer
  (path) -> "http://localhost:#{port}/api#{path}"
else
  (path) -> "/api#{path}"
  
