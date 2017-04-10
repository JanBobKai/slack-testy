# Description:
#   persist all chat in mongo
#
# Events:

mongo = require('mongodb').MongoClient
format = require('util').format

zeroPad = (number) ->
  ('0' + number).slice -2

module.exports = (robot) ->

  robot.hear /^(.*)$/i, (msg) ->
    mdbPw = process.env.MLAB_USER_PW
    url = 'mongodb://Kaimodo:'+mdbPw+'@ds157390.mlab.com:57390/resitems'
    mongo.connect url, (err, db) ->
      if err
        throw err
      date = new Date
      day = "#{date.getFullYear()}-#{zeroPad(date.getMonth() + 1)}-#{zeroPad date.getDate()}"
      user = msg.message.user.name
      message = msg.message.text
      record = {date: date, user: user, message: message}
      db.collection('hubot').update {day: day}, { $push: {comments: record}}, {upsert:true}, (err, db) ->
        throw err if err

