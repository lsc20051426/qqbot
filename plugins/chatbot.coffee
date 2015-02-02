cleverbot = require('cleverbot-node')
log       = new (require 'log')('debug')
request   = require("request")


module.exports = (content ,send, robot, message)->
  if ret = content.match /^chat (.*)/i
    c = new cleverbot()
    c.write(ret[1], (c) => send c.message )
  if ret = content.match /^simi (.*)/i
    api_url = "http://127.0.0.1/simi.php?q=#{ret[1]}"
    log.debug api_url
    request.get api_url, (e,r,data) ->
      log.debug data
      if data
        send data+"\n(结果来自:http://www.simsimi.com/talk.htm)"
      else
        send "我有点忙,等我5秒钟,一会聊!"

