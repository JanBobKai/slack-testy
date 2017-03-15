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
        robot.emit 'slack-attachment',
            channel: "general"
            username: "CustomBotName"
            icon_url: "https://slack.global.ssl.fastly.net/9fa2/img/services/hubot_128.png"
            content:
                fallback: "fallback"
                title: "works now"
                title_link: "https://github.com"
                text: "Shows up"
                image_url: "https://assets-cdn.github.com/images/modules/logos_page/GitHub-Logo.png"
                color: "#111111"