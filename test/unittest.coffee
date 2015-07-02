blanket = require 'blanket'
assert = require 'assert'
Testbot = require 'testbot'

describe 'hubot', ->
  bot = null

  # create
  beforeEach (done)->
    bot = new Testbot
    bot.load './src', ['google.coffee'], done

  afterEach ->
    do bot.clear

  describe 'google', ->
    it 'should send search result on command 구글', (done)->
      bot.send 'hubot 구글 go', (res)->
        assert.equal res, "*The Go Programming Language*\n_ https://golang.org/ _"
        do done

    it 'should send search result with command google', (done)->
      bot.send 'hubot google go', (res)->
        assert.equal res, "*The Go Programming Language*\n_ https://golang.org/ _"
        do done
