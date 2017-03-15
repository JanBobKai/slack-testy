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
#
#
# Author:
#   Kaimodo
module.exports = (robot) ->
    robot.hear /'attachtest' /i, (res) ->
        res.emit 'slack-attachment',
            message: msg.message
            content:
                # see https://api.slack.com/docs/attachments
                text: "Attachment text"
                fallback: "Attachment fallback"
                fields: [{
                title: "Field title"
                value: "Field value"
                }]