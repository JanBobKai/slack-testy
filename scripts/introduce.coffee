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
    res.send 'Test'