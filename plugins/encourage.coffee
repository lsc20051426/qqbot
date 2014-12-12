remarks = [
    "Great job, %!",
    "Way to go, %!",
    "% is amazing, and everyone should be happy this amazing person is around.",
    "I wish I was more like %.",
    "% is good at like, 10 times more things than I am.",
    "%, you are an incredibly sensitive person who inspires joyous feelings in all those around you.",
    "%, you are crazy, but in a good way.",
    "% has a phenomenal attitude.",
    "% is a great part of the team!",
    "I admire %'s strength and perseverance.",
    "% is a problem-solver and cooperative teammate.",
    "% is the wind beneath my wings.",
    "% has a great reputation.",
    "Great job today, everyone!",
    "Go team!",
    "Super duper, gang!",
    "What a great group of individuals there are in here. I'm proud to be chatting with you.",
    "You all are capable of accomplishing whatever you set your mind to.",
    "I love this team's different way of looking at things!",
    "%, 你一定会抢到WHV名额的",
    "%, 你要好好学习英语,加油考雅思",
    "%, No pains,No gains!",
    "%, 据说爆照的话,你的雅思可以7炸",
    "%, 又是一个充满希望的一天!",
    "想抢到SFV名额吗?, %, 请抱紧鸭哥的大腿",
    "赶快去学习!"
]


module.exports = (content ,send, robot, message)->

    if content.match /^encourage$/i
        nickname = message.from_user.nick
        msg = remarks[Math.floor(Math.random() * remarks.length)]
        send msg.replace "%", nickname
