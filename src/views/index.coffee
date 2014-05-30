# index view

React = require 'react'
{h1, p, a, div} = React.DOM

module.exports = React.createClass
  displayName: "Index"
  render: ->
    div null,
      h1 null, "Home"
      p null,
        "View "
        a
          href: "/posts"
          "posts"
        "."

      div
        className: "debug"
        "Rendered #{@props.renderer}-side."
