# grunt build config

module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON "package.json"

    browserify:
      options:
        transform: ['coffeeify']
        browserifyOptions:
          extensions: ['.coffee']
      dist:
        files:
          "www/script.js": ["src/client.coffee"]

  grunt.loadNpmTasks 'grunt-browserify'

  grunt.registerTask 'default', 'browserify'
