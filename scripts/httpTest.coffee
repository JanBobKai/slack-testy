# Description
#   Item aus Datenbank holen
#
# Configuration:
#   None needed. 
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
module.exports = (robot) ->

  robot.hear /reshead (.*)/i, (response) ->
    artistName = response.match[1].toLowerCase()
    if artistName is ""
      response.send "Item Nr 1-8800"
    else
      searchName = artistName.replace(" ", "+")
      robot.http("https://reshead-fbf2.restdb.io/rest/items-de-oac-head-com?q={%20%22Name%22:%20{%22$regex%22%20:%22#{searchName}%22}}&max=1&apikey=58e978ffd52b24c621b8ddbc")
        .header('Content-Type', 'application/json')
        .get() (err, res, body) ->
          if err
            response.send "Oh noes! #{err}"
            return
          if res.statusCode isnt 200
            res.send "Request didn't come back HTTP 200 :("
            return
          data = JSON.parse body
          response.send "Werte: #{data.url}"
