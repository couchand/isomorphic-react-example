# router

director = require 'director'
React    = require 'react'

views = require "./views"

isServer = typeof window is 'undefined'
renderer = if isServer then 'server' else 'client'

firstRender = yes

DirectorRouter = if isServer
  director.http.Router
else
  director.Router

doRoute = if isServer
  (router, component, routeContext) ->
    router.handleServerRoute component, routeContext
else
  (router, component) ->
    router.handleClientRoute component

makeRoute = if isServer
  (handler) ->
    get: @getRouteHandler handler
else
  (handler) ->
    @getRouteHandler handler

class Router
  constructor: (routesFn) ->
    throw new Error "must provide routes" unless routesFn
    @directorRouter = new DirectorRouter @parseRoutes routesFn

  parseRoutes: (routesFn) ->
    me = this
    routes = {}
    routesFn (pattern, handler) ->
      routes[pattern] = makeRoute.call me, handler
    routes

  getRouteHandler: (handler) ->
    me = this
    ->
      routeContext = this
      params = Array.prototype.slice.call arguments
      handleError = me.handleError.bind routeContext

      handleRoute = ->
        handler.apply null, params.concat (err, path, data) ->
          return handleError err if err

          data ?= {}
          data.renderer = renderer

          me.renderView path, data, (err, component) ->
            return handleError err if err

            doRoute me, component, routeContext

      try
        handleRoute()
      catch err
        handleError err

  handleError: (err) ->
    console.error err.message + err.stack

    if @next
      @next err
    else
      alert err.message

  renderView: (path, data, callback) ->
    try
      component = views[path]
      callback null, component data
    catch err
      callback err

  wrapWithLayout: (component, callback) ->
    try
      layout = views.layout
      callback null, layout body: component
    catch err
      callback err

  handleClientRoute: (component) ->
    return firstRender = no if firstRender

    React.renderComponent component,
      document.getElementById "view-container"

  handleServerRoute: (component, {req, res}) ->
    contents = React.renderComponentToString component

    @wrapWithLayout contents, (err, page) ->
      if err
        res.statusCode = 500
        res.send err
        return

      html = React.renderComponentToString page
      res.send html

  middleware: ->
    router = @directorRouter

    (req, res, next) ->
      router.attach -> @next = next
      router.dispatch req, res, (err) ->
        next() if err and err.status is 404

  start: ->
    @directorRouter.configure html5history: yes

    document.addEventListener 'click', (e) =>
      el = e.target
      dataset = el and el.dataset
      redirect = not dataset.passThru

      if el and el.nodeName is 'A' and redirect
        @directorRouter.setRoute el.attributes.href.value
        e.preventDefault()

    @directorRouter.init()

module.exports = Router
