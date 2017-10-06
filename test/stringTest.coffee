chai=require 'chai'
chai.should()

require '../index.coffee'


describe 'string', ->
  describe 'reverse', ->
    it '«abc» doit retourner «cba»', ->
      'cba'.should.equal 'abc'.reverse()

  describe 'sortByFrequency', ->
    it '«rnsasse» doit retourner «easssnr»', ->
      'easssnr'.should.equal 'rnsasse'.sortByFrequency()

  describe 'objectify', ->
    it '«bépoo» doit retourner «{b:1,é:1,p:1,o:2}»',->
      expected=
        'b':1
        'é':1
        'p':1
        'o':2
      expected.should.deep.equal "bépoo".objectify()

  describe 'noDiacritics', ->
    it '«bépô» doit retourner «bepo»', ->
      source='bépô'
      'bepo'.should.equal source.noDiacritics()

  describe 'vowels', ->
    it '«bÉpôoa» doit retourner { e:1, o:2, a:1 }', ->
      expected=
        e:1
        o:2
        a:1
      expected.should.deep.equal 'bÉpôoa'.vowels()

  describe 'consonants', ->
    it '«béPpôoa» doit retourner { b:1, p:2 }', ->
      expected=
        b:1
        p:2
      expected.should.deep.equal 'béPpôoa'.consonants()

  describe 'frenchWords', ->
    it 'doit retourner la liste des mots français connus', ->
      208913.should.equal String::frenchWords().diacritics.length
      208913.should.equal String::frenchWords().simple.length

  describe 'guessFrench', ->
    it '', ->
      1.should.equal JSON.stringify 'ambi'.guessFrench()
