
###
# Chargement des ressources
###
rsc={}
rsc.priority=require '../rsc/letter_priority_fr.coffee'
rsc.diacritics=require '../rsc/diacritics.coffee'
rsc.alphabet=
  e:
    type:'vowel'
  a:
    type:'vowel'
  i:
    type:'vowel'
  b:
    type:'consonant'
  c:
    type:'consonant'
  d:
    type:'consonant'
  f:
    type:'consonant'
  g:
    type:'consonant'
  h:
    type:'consonant'
  j:
    type:'consonant'
  k:
    type:'consonant'
  l:
    type:'consonant'
  m:
    type:'consonant'
  n:
    type:'consonant'
  o:
    type:'vowel'
  p:
    type:'consonant'
  q:
    type:'consonant'
  r:
    type:'consonant'
  s:
    type:'consonant'
  t:
    type:'consonant'
  u:
    type:'vowel'
  v:
    type:'consonant'
  w:
    type:'consonant'
  x:
    type:'consonant'
  y:
    type:'vowel'
  z:
    type:'consonant'

rsc.vowels=[]
Object
  .keys rsc.alphabet
  .forEach (letter)-> rsc.vowels.push letter if rsc.alphabet[letter].type is 'vowel'

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
      throw 'Problème lors du chargement des ressources'
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
    .split''
    .forEach increment
  return vowels

###
# Retourne un objet qui dénombre les consonnes
###
String::consonants=()->
  consonants={}
  increment=(letter)-> consonants[letter]=(consonants[letter] or 0) + 1 if rsc.alphabet[letter].type is 'consonant'
  @noDiacritics()
    .split''
    .forEach increment
  return consonants

