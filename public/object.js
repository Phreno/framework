Object.prototype.stringify = function() {
  return JSON.stringify(this);
};

Object.prototype.flattern = function() {
  var concat, string, that;
  that = this;
  string = '';
  concat = function(key) {
    if (typeof that[key] === 'number') {
      return string += key.repeat(that[key]);
    }
  };
  Object.keys(that).forEach(concat);
  return string;
};
