chai=require 'chai'
chai.should()

require '../src/index.coffee'

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

  describe 'substract', ->
    it '''
    {a:10, b:0, c:3}.substract({a:2, b:5, d:2})
    doit retourner {a:8, b:-5, c:3, d:-2}
    ''', ->
      source=
        a:10
        b:0
        c:3
      substracted=
        a:2
        b:5
        d:2
      substraction=JSON.stringify(source.substract substracted)
      expected=JSON.stringify(
        a:8
        b:-5
        c:3
        d:-2
      )
      expected.should.equal substraction

  describe 'contains', ->
    it '{a:1, b:2} doit contenir {a:1, b:1, c:0}', ->
      source=
        a:1
        b:2
      set=
        a:1
        b:2
        c:0
      expected=true
      expected.should.equal source.contains(set)

    it '{a:1} ne doit pas contenir {b:2}', ->
      source={a:1}
      candidate={b:2}
      expected=false
      console.log source.contains(candidate)
      expected.should.equal source.contains(candidate)
