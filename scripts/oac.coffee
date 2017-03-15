# Description:
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
#
# Notes:
# http://qiita.com/taka0125/items/6260bc7cfc1a5f6026f1
#
# Author:
#   Kaimodo
module.exports = (robot) ->
  robot.respond /testk/, (res) ->
    room = res.envelope.room
    timestamp = new Date/1000|0

    # https://api.slack.com/docs/message-attachments
    attachments = [
      {
        fallback: 'デプロイしたよ',
        color: 'good',
        pretext: 'デプロイしたよ',
        fields: [
          {
            title: 'Command',
            value: 'cap staging deploy',
            short: false
          }
          {
            title: 'Stage',
            value: 'staging',
            short: true
          },
          {
            title: 'Status',
            value: '0',
            short: true
          },
          {
            title: 'Output',
            value: '12323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323123231232312323',
            short: false
          }
        ],
        footer: 'hubot',
        footer_icon: 'https://hubot.github.com/assets/images/layout/hubot-avatar@2x.png',
        ts: timestamp
      },{
          fallback: 'test',
          color: 'danger',
          text: 'bla';
      }
    ]

    options = { as_user: true, link_names: 1, attachments: attachments }

    client = robot.adapter.client
    client.web.chat.postMessage(room, '', options)