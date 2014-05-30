# post view

React = require 'react'
{h1, p, small, div} = React.DOM

module.exports = React.createClass
  displayName: "Post"
  render: ->
    div null,
      h1 null, @props.title
      small null,
        "Posted by #{@props.author} at #{@props.created_at}"
      p null, @props.body
      div
        className: "debug"
        "Rendered #{@props.renderer}-side."
