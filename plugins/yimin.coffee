###
YIMINJIAYUAN 小百科
from yiminjiayuan.com
Written by L(qq,wechat:527248982)
###

log         = new (require 'log')('debug')
request     = require('request')
cheerio = require('cheerio')
Iconv = require('iconv').Iconv
iconv = new Iconv('GBK', 'UTF-8//TRANSLIT//IGNORE')
jschardet = require("jschardet")

module.exports = (content ,send, robot, message)->

    if ret = content.match /^yimin (.*)/i
        keyword = ret[1]
        log.debug keyword
        url = "http://search.yiminjiayuan.com/f/discuz?mod=forum&sId=12744402&ts=1422850305&cuId=38550&cuName=lsc20051426&gId=61&agId=3&egIds=61&fmSign=&ugSign61=&ugSign3=&sign=d8dfdcc2064ca058cec9534403df46bb&source=discuz&fId=0&searchsubmit=true&q=#{keyword}"
        log.debug url
        
        request.get url, (e,r,data)-> 
            if data
                $ = cheerio.load(data);
                log.debug $(".title").length
                text = ""
                $('.title').each((i, el) ->
                    text += $(this).find('a').text() + ": "
                    text += $(this).find('a').attr('href') + "\n"
                )
                text += "\nAll Right Reserved by YIMINJIAYUAN.COM"
                send text.trim()
            else
                send "查询#{keyword} 出错啦,再试一下下"



