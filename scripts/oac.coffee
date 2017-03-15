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
    attachment =
        title: "Test Titel"
        title_link: "http://www.google.de"
        fields: [
            {
                title: "Feld 1"
                value: Text 1
                short: true
            }
        ]
        color: "#006633"
        author_icon: https://developer.atlassian.com/imgs/jira.png"
        
    robot.hear /'atatest' /i, (msg) ->
        msg.robot.adapter.customMessage
                channel: msg.envelope.room
                username: msg.robot.name
                attachments: [attachment]