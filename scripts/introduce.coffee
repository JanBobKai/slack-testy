# Description:
#   Klassenbestimmung der User
#
# Commands:
#   hubot meineKlasse <Klasse> - Setzt deine eigene Klasse fest
#   hubot klasse <Benutzername> - Zeige die Klasse des Benutzers an
#
# Author:
#   Kaimodo inc


module.exports = (robot) ->
  robot.respond /meineKlasse (.*)/i, (res) ->
    intro = res.match[1].trim()
    if not intro?
      res.reply 'Darf nicht leer sein'
      return
    user = res.message.user
    robot.brain.set 'intro-' + user.id, intro
    res.reply "Danke #{user.name}, du hast jetzt die Klasse: #{intro}"

  robot.respond /klasse ([\w.-]*):? (.*)/i, (msg) ->
    msg.send 'Grrrr'