###
WHV 小百科
from whvbaike.com
Written by L(qq,wechat:527248982)
###

log         = new (require 'log')('debug')
request     = require('request')
cheerio = require('cheerio')
Iconv = require('iconv').Iconv
iconv = new Iconv('GBK', 'UTF-8//TRANSLIT//IGNORE')
jschardet = require("jschardet")

module.exports = (content ,send, robot, message)->

    if ret = content.match /^whv (.*)/i
        keyword = ret[1]
        log.debug keyword
        url = "http://whvbaike.com/index.php?search-fulltext-title-#{keyword}--all-0-within-time-desc-1"
        log.debug url
        options = {
            url: url,
            headers: {
                "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                "Accept-Encoding": "gzip, deflate, sdch",
                "Accept-Language": "zh-CN,zh;q=0.8",
                "Cache-Control": "max-age=0",
                # "Connection": "keep-alive",
                # "Cookie": "hd_sid=uvqhUV; pgv_pvi=3996969984; pgv_si=s1544233984; hd_searchtime=1418323204",
                "Host": "whvbaike.com",
                "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"
            },
            encoding: null
        }
        
        request.get options, (e,r,data)->      
            if data
                log.debug jschardet.detect(data)
                data = iconv.convert(data).toString()
                $ = cheerio.load(data);
                log.debug $(".col-dl").length
                text = ""
                $('.col-dl').each((i, el) ->
                    if $(this).find('.h2 a').length == 0
                        text = $(this).text().trim()
                        log.debug text
                    else
                        text += $(this).find('.h2 a').text() + ": "

                        text += "http://whvbaike.com/" + $(this).find('.h2 a').attr('href') + "\n"
                        log.debug $(this).find('.h2 a').text()
                        log.debug $(this).find('.h2 a').attr('href')
                )
                send text.trim()
            else
                send e
