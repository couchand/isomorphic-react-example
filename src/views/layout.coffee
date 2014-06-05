# layout

React = require 'react'
{html, head, title, link, body, div, script} = React.DOM

module.exports = React.createClass
  displayName: "Layout"
  render: ->
    html null,
      head null,
        title null, "Isomorphic React Example"
        link href: "/style.css", rel: "stylesheet"

      body null,
        div
          className: "container"
          id: "view-container"
          dangerouslySetInnerHTML: __html: @props.body

        script src: "/script.js"
