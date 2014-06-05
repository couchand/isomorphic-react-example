isomorphic React application example
====================================

A rewrite of Spike Brehm's [great tutorial][0], this is an example of
basic architecture for an isomorphic application written in
[CoffeeScript][2] and built with [React][3].

  * overview
  * getting started
  * differences from the original

overview
--------

A "minimum-viable example of an isomorphic app".  The same code runs
the client and the server.  Because, Don't Repeat Yourself.  Spike
recommends a [blog post][1] by Charlie Robbins for an introduction.

A simple "blog" app, featuring a listing of posts.  The first page
load is rendered on the server: application code produces a React
component and the router renders it to a string of html to send.
Further navigation is completely client-side.  Here, the very same
application code produces a React component which is rendered live
into the DOM.

getting started
---------------

  * Install [node.js](http://nodejs.org)
  * Install `grunt-cli`

```bash
npm install -g grunt-cli
```

  * Clone this repository

```bash
git clone git@github.com:couchand/isomorphic-react-example.git
cd isomorphic-react-example
```

  * Install the node module dependencies

```bash
npm install
```

  * Build the client side code package

```bash
grunt
```

  * Start the server

```bash
coffee src/server.coffee
```

  * Visit the app in your web browser at `http://localhost:3030`

```bash
coffee firefox localhost:3030
```

Click around on some links.  Hit back and forward.  Hit reload.
Watch the note in the bottom-right corner the whole time.  Open your
developer console and watch the terminal the server is running in for
insight and maximum fun.

differences from the original
-----------------------------

Obviously the biggest difference from the original is the language.
CoffeeScript's expressivity allowed me to rewrite the example in
far fewer lines.

Using React from the start allowed some significant simplification as
well.  Spike's tutorial does have a React branch, but it's an update
to a Handlebars-based application and still uses Handlebars for the
layout.  In addition, I find CoffeeScript's object literal and
deconstructing syntaxes make writing React without JSX much more
elegant.  Not to mention that CoffeeScript's string interpolation
makes a templating library unnecessary.

I also think code organization becomes very important on an
isomorphic project.  To that end, rather than following Spike's more
conventional structure of `app`, `lib`, and `index.js`, I've used an
explicitly symmetric one: `client.coffee` and `server.coffee` for
the entry points and `api-client.coffee` and `api-server.coffee` for
the api endpoints.  On a real project more structure still would be
required, and recognizing and highlighting shared, private, and
symmetric code can help drive that structure.

[0]: https://www.github.com/spikebrehm/isomorphic-tutorial
[1]: http://blog.nodejitsu.com/scaling-isomorphic-javascript-code
[2]: http://coffeescript.org
[3]: https://facebook.github.io/react
