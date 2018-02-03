#!/usr/bin/env coffee
require '../src/index.coffee'
fs=require 'fs'
file='./rsc/words_fr_objectified.js'

template=
"""
module.exports=[
#DATA#
]
"""
data=String::frenchWords()
  .simple
  .map (el)-> return el.objectify().stringify()

fs.writeFileSync file, template.replace('#DATA#', data.join(',\n'))
