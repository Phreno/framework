#!/usr/bin/env coffee
require '../index.coffee'
fs= require 'fs'

file='./rsc/words_fr_no_diacritics.js'
data=String::frenchWords()
  .map (el)-> return el.noDiacritics()
  .join '\n'

fs.writeFileSync file, data
