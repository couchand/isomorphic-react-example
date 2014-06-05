# posts view

React = require 'react'
{h1, ul, li, a, div} = React.DOM

module.exports = React.createClass
  displayName: "Posts"
  render: ->
    div null,
      h1 null, "Posts"
      ul null,
        for post in @props.posts
          li
            key: post.id
            a
              href: "/posts/#{post.id}"
              post.title
 
      div
        className: "debug"
        "Rendered #{@props.renderer}-side."
