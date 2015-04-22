# Description:
#   A way to interact with the Google Web API.
#
# Commands:
#   hubot google|g|구글 <query> - Queries Google Web for <query> and returns the first result.

module.exports = (robot) ->
  robot.respond /(g|google|구글) (.*)/i, (msg) ->
    googleMe msg, msg.match[2], (url) ->
      msg.send url

googleMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/web')
    .query(v: '1.0', q: query)
    .get() (err, res, body) ->
      pages = JSON.parse(body)
      pages = pages.responseData?.results
      if pages?.length > 0
        page = pages[0]
        cb "*#{page.titleNoFormatting}*\n_ #{page.unescapedUrl} _"
