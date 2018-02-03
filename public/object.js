
/*
 * Retourne un objet sous forme de string
 */
Object.prototype.stringify = function() {
  return JSON.stringify(this);
};


/*
 * Applatit un objet signature sous forme de string
 */

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


/*
 * Retourne la signature déduite du candidat
 */

Object.prototype.substract = function(candidate) {
  var substract, substraction;
  substraction = this;
  substract = function(key) {
    if (substraction[key] == null) {
      return substraction[key] = 0 - candidate[key];
    } else {
      substraction[key] -= candidate[key];
      if (substraction[key] === 0) {
        return delete substraction[key];
      }
    }
  };
  Object.keys(candidate).forEach(substract);
  return substraction;
};


/*
 * Est ce que la signature A contient B
 */

Object.prototype.contains = function(B) {
  var A, AisBiggerThanB;
  A = this;
  AisBiggerThanB = function(key) {
    if (B[key] === 0) {
      return true;
    }
    if (A[key] === void 0) {
      return false;
    } else {
      return A[key] >= B[key];
    }
  };
  return Object.keys(B).every(AisBiggerThanB);
};
