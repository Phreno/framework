Object::stringify=->
  return JSON.stringify @
Object::flattern=->
  that=@
  string=''
  concat=(key)->string+=key.repeat that[key] if typeof that[key]=='number'
  Object
    .keys that
    .forEach concat
  return string

