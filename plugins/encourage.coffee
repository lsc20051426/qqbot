remarks = [
    "%, 你一定会抢到WHV名额的",
    "%, 你要好好学习英语,加油考雅思",
    "加油%, 你一定会进鸭哥WHV团队的!",
    "%, No pains,No gains!",
    "%, 据说爆照的话,你的雅思可以7炸",
    "%, 又是一个充满希望的一天!",
    "想抢到SFV名额吗?, %, 请抱紧鸭哥的大腿",
    "%，你今天去yiminer.com去读精华帖子吗?",
    "赶快去学习!"
]


module.exports = (content ,send, robot, message)->

    if content.match /^encourage$/i
        nickname = message.from_user.nick
        msg = remarks[Math.floor(Math.random() * remarks.length)]
        send msg.replace "%", nickname
