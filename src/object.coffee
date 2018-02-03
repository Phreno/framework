###
# Retourne un objet sous forme de string
###
Object::stringify=->
  return JSON.stringify @

###
# Applatit un objet signature sous forme de string
###
Object::flattern=->
  that=@
  string=''
  concat=(key)->string+=key.repeat that[key] if typeof that[key]=='number'
  Object
    .keys that
    .forEach concat
  return string


###
# Retourne la signature déduite du candidat
###
Object::substract=(candidate)->
  substraction=@
  substract=(key)->
    if not substraction[key]?
      substraction[key]=0-candidate[key]
    else
      substraction[key]-=candidate[key]
      delete substraction[key] if substraction[key] is 0
  Object
    .keys candidate
    .forEach substract
  return substraction

###
# Est ce que la signature A contient B
###
Object::contains=(B)->
  A=@

  AisBiggerThanB=(key)->
    if B[key] is 0
      return true
    if A[key] is undefined
      return false

    else return A[key] >= B[key]

  return Object
    .keys(B)
    .every(AisBiggerThanB)
