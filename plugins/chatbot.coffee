cleverbot = require('cleverbot-node')
log       = new (require 'log')('debug')
jschardet = require("jschardet")
request   = require("request")

String::endsWith   ?= (s) -> s == '' or @slice(-s.length) == s

sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms


module.exports = (content ,send, robot, message)->
  if ret = content.match /^chat (.*)/i
    c = new cleverbot()
    c.write(ret[1], (c) => send c.message )
  if ret = content.match /^simi (.*)/i
    cookieurl = "http://127.0.0.1:8080/"
    request.get {url: cookieurl} , (e,r,cookie) -> 
        url = "http://www.simsimi.com/func/reqN?lc=ch&ft=0.0&req=#{ret[0]}&fl=http%3A%2F%2Fwww.simsimi.com%2Ftalk.htm"
        options = {
            url: url,
            json: true,
            headers: {
                "Accept":"application/json, text/javascript, */*; q=0.01",
                "Accept-Encoding":"gzip, deflate, sdch",
                "Accept-Language":"en,zh-CN;q=0.8,zh;q=0.6",
                "Content-Type":"application/json; charset=utf-8",
                "Cookie": cookie,
                "Host":"www.simsimi.com",
                "Referer":"http://www.simsimi.com/talk.htm",
                "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36",
                "X-Requested-With":"XMLHttpRequest"
            }
        }
        request.get options, (e, r, data)->
            log.debug data 
            if data and data.result == 200
                if data.msg == "OK"
                    send data.sentence_resp
                else
                    request.get 'http://127.0.0.1:8080/refresh'
                    send "容我休息两秒钟,再和你大战三百回合!!"
            else
                request.get 'http://127.0.0.1:8080/refresh'
                send "容我休息两秒钟,再和你大战三百回合!!"

