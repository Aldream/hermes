module.exports =

    initialize: ->

        console.log 'Starting hermes...'

        # Makes this object immuable.
        Object.freeze this if typeof Object.freeze is 'function'

