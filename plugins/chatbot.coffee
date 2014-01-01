cleverbot = require('cleverbot-node')
log       = new (require 'log')('debug')
jschardet = require("jschardet")
request   = require("request")

module.exports = (content ,send, robot, message)->

  if ret = content.match /^chat (.*)/i
    c = new cleverbot()
    c.write(ret[1], (c) => send c.message )

  if ret = content.match /^simi (.*)/i
    msg = ret[1]
    url = "http://www.simsimi.com/func/reqN?lc=ch&ft=0.0&req=#{msg}&fl=http%3A%2F%2Fwww.simsimi.com%2Ftalk.htm"
    options = {
        url: url,
        json: true,
        headers: {
            "Accept":"application/json, text/javascript, */*; q=0.01",
            "Accept-Encoding":"gzip, deflate, sdch",
            "Accept-Language":"en,zh-CN;q=0.8,zh;q=0.6",
            "Content-Type":"application/json; charset=utf-8",
            "Cookie":"sid=s%3AcT0twRzYBoCRuw2lpAE1mvTf.Q61P%2BhxRYxtVviaZNAycE%2FlQyRTOXYlZcrt2ez8xPls; AWSELB=BF8D19F26622D89F6936CA1E73D2A1C3FB17942847373FED5B1042678F453AEF915A2A4FA58CE0EE151EB3898667781E2C3E6DFD1F4741ABBB966B98FDE0204A4ED81852; simsimi_uid=82764308; simsimi_uid=82764308; isFirst=1; isFirst=1; fbm_370812466271816=base_domain=.simsimi.com; selected_nc_name=Chinese%20%u2013%20Simplified%20%28%u7C21%u9AD4%29; selected_nc_name=Chinese%20%u2013%20Simplified%20%28%u7C21%u9AD4%29; fbPostCookie=1; fbPostCookie=1; Filtering=0.0; Filtering=0.0; lang=zh_CN; teach_btn_url=talk; teach_btn_url=talk; __utmt=1; selected_nc=ch; selected_nc=ch; menuType=web; menuType=web; fbsr_370812466271816=oY9UfJ3qfaV9CPDZSEMEksjJzcqFwpqhTpfLpxF_HMo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUUJ1Sks4cFFReldlWEs4YlBxRzBjN1ZQTEgzNzBJZzdOaWxnR3A3ejluVDJfQ0NYZ0pyaVVXRlJhVkVsZ0ZRRUJsQ0pyMjlzRTlGdVBxZVB6dllnT093YmNvMVlYT0FHaXhWX2hQTl9PLVUtLUNjZENaN2VyM0o0eVVzbElvajF6aWlCSDA3eFJYSVMyejFucWdKYURfVmtGcDNuYmJvdklFdk5uUVBlX0NEZ1RHLVB2a25haGZGVGpNSllrVy05UGxKQzh0OUhNRGZhQy03WHZzeGJNWUpDTXR2ZWgtVzhIbVNockJSWWJueGFJaHR1VE5FVENoSnRCOXpKS21fYnhuSHhIUXJZWWFwRU1wTVAwT0Y1MkVuNXoxMVZlNEc2WFdQOTRZRHluWVhGdm5DY1A2RHh4N2ZUTk15TFFKV0pfTXFqUUNnTl9UQnFhNFRpZ1lmcFNOOSIsImlzc3VlZF9hdCI6MTQxODM4Mjc4MSwidXNlcl9pZCI6IjEwMDAwNDEyMDYzNDQ1MCJ9; fb_id=100004120634450; fb_id=100004120634450; __utma=119922954.2008631751.1418368529.1418368529.1418379253.2; __utmb=119922954.64.9.1418382793299; __utmc=119922954; __utmz=119922954.1418368529.1.1.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)",
            "Host":"www.simsimi.com",
            "Referer":"http://www.simsimi.com/talk.htm",
            "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36",
            "X-Requested-With":"XMLHttpRequest"
        }
    }

    request.get options, (e,r,data)-> 
        log.debug data  
        if data and data.result == 200
            send data.sentence_resp
        else
            send "太快了,我有点受不了!"

