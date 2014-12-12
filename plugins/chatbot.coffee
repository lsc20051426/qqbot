cleverbot = require('cleverbot-node')
log       = new (require 'log')('debug')


module.exports = (content ,send, robot, message)->
  c = new cleverbot()

  if ret = content.match /^chat (.*)/i
  	log.debug content
  	log.debug ret[1]
  	c.write(ret[1], (c) => send c.message )
