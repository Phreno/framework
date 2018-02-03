
/*
 * Renvoie un tableau sous forme de chaîne
 */
var base;

Array.prototype.stringify = function() {
  return JSON.stringify(this);
};


/*
 * Duplique un tableau mais pas l'instance
 */

Array.prototype.clone = function() {
  return this.slice(0);
};


/*
 * Renvoie un tableau random
 */

if ((base = Array.prototype).shuffle == null) {
  base.shuffle = function() {
    var i, j, k, ref, ref1, that;
    that = this.clone();
    if (that.length > 1) {
      for (i = k = ref = that.length - 1; ref <= 1 ? k <= 1 : k >= 1; i = ref <= 1 ? ++k : --k) {
        j = Math.floor(Math.random() * (i + 1));
        ref1 = [that[j], that[i]], that[i] = ref1[0], that[j] = ref1[1];
      }
    }
    return that;
  };
}
