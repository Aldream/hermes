americano = require 'americano'

port = process.env.PORT || 2345
americano.start name: 'hermes', port: port
