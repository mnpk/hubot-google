path = require 'path'
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
# Load assertion methods to this scope
chai = require 'chai'
blanket = require 'blanket'
# nock = require 'nock'
{ expect } = chai


describe 'hubot', ->
  robot = null
  user = null
  adapter = null

  beforeEach (done)->
    robot = new Robot null, 'mock-adapter', yes, 'hubot'
    robot.adapter.on 'connected', ->
      # Project script
      process.env.HUBOT_AUTH_ADMIN = "1"
      hubotScripts = path.resolve 'node_modules', 'hubot', 'src', 'scripts'
      # robot.loadFile hubotScripts, 'auth.coffee'
      # load files to test
      robot.loadFile path.resolve('.', 'src'), 'google.coffee'
      # create user
      user = robot.brain.userForId '1', {
        name: 'mocha',
        root: '#mocha'
      }
      adapter = robot.adapter
      do done
    do robot.run

  afterEach ->
    do robot.server.close
    do robot.shutdown

  describe 'google', ->
    it 'should send search result with command 구글', (done)->
      adapter.on 'send', (env, str)->
        result = "*The Go Programming Language*\n_ https://golang.org/ _"
        expect(str[0]).to.equal result
        do done
      adapter.receive new TextMessage user, 'hubot 구글 go'
    it 'should send search result with command google', (done)->
      adapter.on 'send', (env, str)->
        result = "*The Go Programming Language*\n_ https://golang.org/ _"
        expect(str[0]).to.equal result
        do done
      adapter.receive new TextMessage user, 'hubot google go'
