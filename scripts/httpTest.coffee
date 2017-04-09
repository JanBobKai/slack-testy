# Description
#   Item aus Datenbank holen
#
# Configuration:
#   FIREBASE_URL - eg https://your_firebase.firebaseio.com/hubot
#   FIREBASE_SECRET - (optional) Authentication to FireBase
#
# Commands:
#   reshead <Nummer>
#
#
# Author:
#   Kaimodo
#   response.send "#{data.url.items[0]}"
#   https://resishead.firebaseio.com/.json?orderBy="$key"&startAt="Zith"&endAt="b\uf8ff"&print=pretty
#   https://reshead-fbf2.restdb.io/rest/items-de-oac-head-com?q={%22Name%22:%22Brustpanzer%20des%20Glaubensverteidigers%22}
#  https://reshead-fbf2.restdb.io/rest/items-de-oac-head-com?q={%20%22Name%22:%20{%22$regex%22%20:%22Zit%22}}
#  https://reshead-fbf2.restdb.io/rest/items-de-oac-head-com?q={%20%22Name%22:%20{%22$regex%22%20:%22Zit%22}}&max=1
#   https://reshead-fbf2.restdb.io/rest/items-de-oac-head-com?q={ "Name": {"$regex" :"#{searchName}"}}&max=1
#  https://resishead.firebaseio.com/#{searchName}.json?print=pretty
# Require Firebase dependencies
Firebase                = require 'firebase'
FirebaseTokenGenerator = require 'firebase-token-generator'

#main
module.exports = (robot) ->

  
  # Do not load unless configured
  return robot.logger.warning "firebase-brain: FIREBASE_URL not set. Not attempting to load FireBase " unless process.env.FIREBASE_URL?

  robot.logger.info "firebase-brain: Connecting to FireBase at #{process.env.FIREBASE_URL} "

  robot.hear /reshead (.*)/i, (response) ->
    artistName = response.match[1].toLowerCase()
    if artistName is ""
      response.send "Item Nr 1-8800"
    else
      searchName = artistName.replace(" ", "+")
      robot.http("#{process.env.FIREBASE_URL}.json?print=pretty")
        .header('Content-Type', 'application/json')
        .get() (err, res, body) ->
          if err
            response.send "Oh noes! #{err}"
            return
          if res.statusCode isnt 200
            res.send "Request didn't come back HTTP 200 :("
            return

          data = null
          try
            data = JSON.parse body
            console.log body
          catch error
           res.send "Ran into an error parsing JSON :("
           return

          response.send "Werte: #{data}"
