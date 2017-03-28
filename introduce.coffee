# Description:
#   Klassenbestimmung der User
#
# Commands:
#   hubot meineKlasse <Klasse> - Setzt deine eigene Klasse fest
#   hubot klasse <Benutzername> - Zeige die Klasse des Benutzers an
#
# Author:
#   Kaimodo


module.exports = (robot) ->

  robot.respond /meineKlasse (.*)/i, (msg) ->
    intro = msg.match[1].trim()
    if not intro?
      msg.reply 'Darf nicht leer sein'
      return
    user = msg.message.user
    robot.brain.set 'intro-' + user.id, intro
    msg.reply "Danke #{user.name}, du hast jetzt die Klasse: #{intro}"

  robot.respond /klasse (?!me as )@?([\w .\-]+)\?*$/i, (msg) ->
    name = msg.match[1].trim()
    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      intro = robot.brain.get 'intro-' + user.id
      if intro?
        msg.reply intro
      else
        msg.reply "#{name} hat noch keine Klasse festgelegt"
    else
msg.reply "Ich finde niemand der #{name} heist."