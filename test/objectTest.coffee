chai=require 'chai'
chai.should()

require '../index.coffee'

describe 'object', ->
  describe 'stringify', ->
    it '{a:1,b:"auie1"} doit retourner «{a:1,b:"auie1"}»', ->
      expected='{"a":1,"b":"auie1"}'
      source=
        a:1
        b:'auie1'
      expected.should.equal source.stringify()

  describe 'flattern', ->
    it '{a:1,b:2,cd:3,auie:"auie"} doit retourner «abbcdcdcd»', ->
      source=
        a:1
        b:2
        cd:3
        auie:'auie'
      expected='abbcdcdcd'
      expected.should.equal source.flattern()

