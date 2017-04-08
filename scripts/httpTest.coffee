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

module.exports = (robot) ->

  robot.hear /reshead (.*)/i, (response) ->
    artistName = response.match[1].toLowerCase()
    if artistName is "Kaimodo"
      response.send "Item Nr 1-8800"
    else
      searchName = artistName.replace(" ", "+")
      robot.http("https://resishead.firebaseio.com/#{searchName}.json")
        .get() (err, res, body) ->
          if err
            response.send "Oh noes! #{err}"
            return
          data = JSON.parse body
          response.send "#{data.url.items[0]}"


robot.hear /spotify (.*)/i, (response) ->
    artistName = response.match[1].toLowerCase() //take the text after Spotify and downcase it
    if artistName is "creed" // ensure musical tastes are up to snuff before taxing the API
      response.send "Sorry, I only search for music."
    else
      searchName = artistName.replace(" ", "+") // format query for API request
      robot.http("https://api.spotify.com/v1/search?q=#{searchName}&type=artist")
        .get() (err, res, body) ->
          if err // check for errors
            response.send "Oh noes! #{err}"
            return
          data = JSON.parse body // parse the JSON response
          response.send "#{data.artists.items[0].external_urls.spotify}" 
          // this grabs and sends the URL of their top tracks collection

