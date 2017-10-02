chai=require 'chai'
chai.should()

require '../src/array.coffee'

describe 'array', ->
  describe 'stringify', ->
    it '[1,2,3] doit retourner «[1,2,3]»', ->
      '[1,2,3]'.should.equal [1,2,3].stringify()

  describe 'clone', ->
    it 'doit retourner un clône qui se détache de l\'instance', ->
      source=[1,2,3]
      target=source.clone()
      source
        .should
        .not
        .equal target
      compare=(el,i)->
        source[i].should.equal target[i]
      target.forEach compare

  describe 'shuffle', ->
    it '«[1,2,3,4]» ne devrait pas conserver les mêmes index',->
      source=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      random=source.shuffle()

      source
        .stringify()
        .should.not.equal random.stringify




