blanket = require 'blanket'
tbot = require 'tbot'

describe 'hubot', ->
  testbot = null

  # create
  beforeEach (done)->
    testbot = new tbot done
    testbot.load './src/google.coffee'

  afterEach ->
    do testbot.clear

  describe 'google', ->
    it 'should send search result with command 구글', ()->
      testbot.send 'hubot 구글 go', (res)->
        assert.equal res, "*The Go Programming Language*\n_ https://golang.org/ _"

    it 'should send search result with command google', ()->
      testbot.send 'hubot google go', (res)->
        assert.equal res, "*The Go Programming Language*\n_ https://golang.org/ _"
