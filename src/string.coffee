
###
# Chargement des ressources
###
rsc={}
rsc.priority=require '../rsc/letter_priority_fr.coffee'
rsc.diacritics=require '../rsc/diacritics.coffee'

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
  @split ''
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
