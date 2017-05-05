# Description
#   SlackのEmoji Reactionを付与
#
# Configuration:
#   HUBOT_SLACK_TOKEN

request = require('request')

module.exports = (robot) ->
  addReactions = (msg, name) ->
    options = {
      url: 'https://slack.com/api/reactions.add'
      qs: {
        'token': process.env.HUBOT_SLACK_TOKEN
        'name': name
        'channel': msg.message.rawMessage.channel
        'timestamp': msg.message.rawMessage.ts
      }
    }
    request.post options, (err, res, body) ->      
      if err? or res.statusCode isnt 200
        robot.logger.error("Failed to add emoji reaction #{JSON.stringify(err)}")
      console.log 'Found: ', body
  robot.hear /^gj|GJ$/i, (msg) ->
    addReactions(msg, 'thumbsup')