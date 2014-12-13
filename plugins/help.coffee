###
插件支持两个方法调用
 init(robot)
 received(content,send,robot,message)
 stop(robot)
 
 1.直接使用 
 module.exports = func 为快捷隐式调用 received 方法
 2.或
 module.exports = {
   init:      init_func       # 初始化调用
   received:  received_func   # 接受消息
   stop:      init_func       # 停止插件（比如端口占用）
 }
#Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
# groups = [1762379213, 608679695, 3855906352]
#if message.type == 'group_message' and message.from_gid in groups
#  log.debug "DEBUG-HELPER", message
#  msg = message.from_user.nick + '在' + message.from_group.name + '群里说:' + content
#  log.debug msg
#  groups.remove(message.from_gid)
#  log.debug "DEBUG-HELPER", groups
#  for group in groups
#    robot.send_message_to_group group, msg
###

HELP_INFO = """
    about           #版本信息和关于
    help            #本内容
    whv             #查询WHV百科的内容
    chat            #用英文和CleverBot机器人聊天
    comic           #来一句心灵鸡汤
    encourage       #让机器人鼓励自己
    simi            #用任何语言和Simsimi机器人聊天
    暂时不支持图片和表情(少了很多乐趣LOL)
"""

fs = require 'fs'
Path = require 'path'
file_path = Path.join __dirname, "..", "package.json"
bundle = JSON.parse( fs.readFileSync file_path )
log   = new (require 'log')('debug')


VERSION_INFO = """
    v#{bundle.version} qqbot
    http://github.com/lsc20051426/qqbot
    本工具基于QQBot二次开发,专为澳洲WHA高端技术交流群(70234147),新西兰WHV高端技术交流群(280576585),新西兰SFV银蕨高端技术交流群(252521690)三大群服务.
    开发者L(qq:527248982)
"""

###
 @param content 消息内容
 @param send(content)  回复消息
 @param robot qqbot instance
 @param message 原消息对象
###

# IMPROVE: 方式不优雅，应该是一个模式识别成功，别的就不应调用到
module.exports = (content ,send, robot, message)->

  if content.match /^help$/i
    send HELP_INFO

  if content.match /^VERSION|ABOUT$/i
    send VERSION_INFO

  if content.match /^plugins$/i
    send "插件列表：\n" + robot.dispatcher.plugins.join('\r\n')

  if content.match /^time$/i
    send "冥王星引力精准校时：" + new Date()

  if ret = content.match /^echo (.*)/i
    send ret[1]
      
  if content.match /^uptime$/i
    secs  = process.uptime()    
    [aday,ahour]  = [86400 ,3600]
    [day,hour,minute,second] = [secs/ aday,secs%aday/ ahour,secs%ahour/ 60,secs%60].map (i)-> parseInt(i)
    t = (i)-> "0#{i}"[-2..] # 让时间更漂亮
    memory = process.memoryUsage().rss / 1024 / 1024
    send "up #{day} days, #{t hour}:#{t minute}:#{t second} | mem: #{memory.toFixed(1)}M"
    
  if content.match /^roll$/i
    # TODO:who? , need a reply method
    send Math.round( Math.random() * 100)
