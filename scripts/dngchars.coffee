# Description:
#   TestScript
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   dng.chars
#
# Notes:
# http://qiita.com/taka0125/items/6260bc7cfc1a5f6026f1
#
# Author:
#   Kaimodo
module.exports = (robot) ->
  robot.hear /dng.chars/, (res) ->
    room = res.envelope.room
    timestamp = new Date/1000|0

    # https://api.slack.com/docs/message-attachments
    attachments = [
      {
        fallback: 'dungeonChars',
        color: 'danger',
        pretext: 'Gebrauchte Charaktere je Dungeon',
        fields: [
          {
            title: 'DDL',
            value: ':heal: | :mili: | :tank: und ein DD nach Wahl',
            short: true
          },{
            title: 'RTL',
            value: ':heal: | :gazer: | :tank: | :tank:'
          }
        ]        
      },{
        color: 'warning',
        fields: [
          {
            title: 'DSL',
            value: ':heal: | :mili: oder :tank: ',
            short: true
          }
        ]   
      },{
        color: 'good',
        fields: [
          {
            title: 'SFL',
            value: ':heal: | :mili: | :tank: und ein DD nach Wahl',
            short: true
          }
        ]   
      },{
          fallback: 'test',
          color: 'grey',
          footer: 'resis',
          footer_icon: 'https://avatars.slack-edge.com/2017-03-09/151204178657_8ed2b3731b17d14bfdf9_48.png',
          ts: timestamp
      }
    ]

    options = { as_user: true, link_names: 1, attachments: attachments }

    client = robot.adapter.client
    client.web.chat.postMessage(room, '', options)