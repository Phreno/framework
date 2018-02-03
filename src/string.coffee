
# coffeelint: disable=max_line_length

###
# Chargement des ressources
###
rsc                        = {}
rsc.priority               = require '../rsc/letter_priority_fr.js'
rsc.diacritics             = require '../rsc/diacritics.js'
rsc.alphabet               = require '../rsc/alphabet.js'
rsc.words_fr               = require '../rsc/words_fr.js'
rsc.words_fr_no_diacritics = require '../rsc/words_fr_no_diacritics.js'
rsc.words_fr_objectified   = require '../rsc/words_fr_objectified.js'

###
# Retourne un tableau contenant
# toutes les voyelles de la
# chaîne
###
rsc.vowels=[]
Object
  .keys rsc.alphabet
  .forEach (letter)-> rsc.vowels.push letter if rsc.alphabet[letter].type is 'vowel'

###
# Retourne un tableau contenant
# toutes les consonnes de la
# chaîne
###
rsc.consonants=[]
Object
  .keys rsc.alphabet
  .forEach (letter)-> rsc.vowels.push letter if rsc.alphabet[letter].type is 'consonant'


###
# Retourne la chaîne renversée
###
String::reverse=->
  return @split ''
    .reverse()
    .join ''

###
# Tri les lettres par fréquence décroissante
###
String::sortByFrequency=->
  byFrequency=(a,b)->
    if not rsc.priority
      throw new Exception 'Problème lors du chargement des ressources'
    return rsc.priority[a]-rsc.priority[b]
  return @split ''
    .sort byFrequency
    .join ''

###
# Transforme une chaîne en object énumérant les lettres
###
String::objectify=->
  obj={}
  count=(letter)->obj[letter]=(obj[letter]||0)+1
  @split ''
    .forEach count
  return obj

###
# Remplace les lettres accentuées
###
String::noDiacritics=->
  that=@
  replace=(diacritic)->
    that=that.replace rsc.diacritics[diacritic], diacritic
  Object
    .keys rsc.diacritics
    .forEach replace
  return that

###
# Retourne un objet qui dénombre les voyelles
###
String::vowels=->
  vowels={}
  increment=(letter)-> vowels[letter]=(vowels[letter] or 0) + 1 if rsc.alphabet[letter].type is 'vowel'
  @noDiacritics()
    .split ''
    .forEach increment
  return vowels

###
# Retourne un objet qui dénombre les consonnes
###
String::consonants=()->
  consonants={}
  increment=(letter)-> consonants[letter]=(consonants[letter] or 0) + 1 if rsc.alphabet[letter].type is 'consonant'
  @noDiacritics()
    .split ''
    .forEach increment
  return consonants

###
# Retourne un tableau qui contient l'ensemble des
# mots en français
###
String::frenchWords=()-> return {
  simple     : rsc.words_fr_no_diacritics.slice 0
  diacritics : rsc.words_fr.slice 0
  objectified: rsc.words_fr_objectified.slice 0
}

###
# Retourne les mots français qui contiennent
# les lettres contenues dans la chaîne
###
String::guessFrench=()->
  candidate=@
    .noDiacritics()
    .objectify()
  suggestions=[]
  populateIfContained=(word, index)->
    cutOff=candidate.length > word.length
    if cutOff
      return
    else if word.contains candidate
      suggestions.push(String::frenchWords().diacritics[index])
  String::frenchWords()
    .objectified
    .forEach populateIfContained
  return suggestions
