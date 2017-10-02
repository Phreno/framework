###
# Renvoie un tableau sous forme de chaîne
###
Array::stringify=->
  return JSON.stringify @

###
# Duplique un tableau mais pas l'instance
###
Array::clone=()->
  return @slice 0

###
# Renvoie un tableau random
###
Array::shuffle ?= ->
  that=@clone()
  if that.length > 1 then for i in [that.length-1..1]
    j = Math.floor Math.random() * (i + 1)
    [that[i], that[j]] = [that[j], that[i]]
  that
