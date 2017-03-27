# Description:
#   alarm wo narase!!
#
# Commands:
#   hubot timer <int> [<text>] - <int> byou go ni <text> wo hyouji
#   hubot alarm 12:34 [<text>] - 12:34 ni <text> wo hyouji

module.exports = (robot) ->
  robot.respond /timer (\d+) ?(.+)?/i, (msg) ->
    time = msg.match[1] * 1000
    text = msg.match[2] ? 'ジリリリリリリリ'
    setTimeout ->
      msg.send text
    , time

  robot.respond /alarm (\d{2}:\d{2}) ?(.+)?/i, (msg) ->
    time = msg.match[1]
    text = (msg.match[2] ? 'ジリリリリリリリ') + ' > ' + msg.message.user.name

    msg.send '受け付けました'

    timer = setInterval ->
      date = new Date()
      h = date.getHours()
      h = '0' + h if h < 10
      m = date.getMinutes()
      m = '0' + m if m < 10
      console.log h + ':' +m
      if time == (h + ':' +m)
        msg.send text if time == (h + ':' +m)
        clearTimeout timer
, 60000