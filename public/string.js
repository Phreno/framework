
/*
 * Chargement des ressources
 */
var rsc;

rsc = {};

rsc.priority = require('../rsc/letter_priority_fr.coffee');

rsc.diacritics = require('../rsc/diacritics.coffee');

rsc.alphabet = require('../rsc/alphabet.coffee');

rsc.words_fr = require('../rsc/words_fr.js');

rsc.words_fr_no_diacritics = require('../rsc/words_fr_no_diacritics.js');


/*
 * Retourne un tableau contenant
 * toutes les voyelles de la
 * chaîne
 */

rsc.vowels = [];

Object.keys(rsc.alphabet).forEach(function(letter) {
  if (rsc.alphabet[letter].type === 'vowel') {
    return rsc.vowels.push(letter);
  }
});


/*
 * Retourne un tableau contenant
 * toutes les consonnes de la
 * chaîne
 */

rsc.consonants = [];

Object.keys(rsc.alphabet).forEach(function(letter) {
  if (rsc.alphabet[letter].type === 'consonant') {
    return rsc.vowels.push(letter);
  }
});


/*
 * Retourne la chaîne renversée
 */

String.prototype.reverse = function() {
  return this.split('').reverse().join('');
};


/*
 * Tri les lettres par fréquence décroissante
 */

String.prototype.sortByFrequency = function() {
  var byFrequency;
  byFrequency = function(a, b) {
    if (!rsc.priority) {
      throw 'Problème lors du chargement des ressources';
    }
    return rsc.priority[a] - rsc.priority[b];
  };
  return this.split('').sort(byFrequency).join('');
};


/*
 * Transforme une chaîne en object énumérant les lettres
 */

String.prototype.objectify = function() {
  var count, obj;
  obj = {};
  count = function(letter) {
    return obj[letter] = (obj[letter] || 0) + 1;
  };
  this.split('').forEach(count);
  return obj;
};


/*
 * Remplace les lettres accentuées
 */

String.prototype.noDiacritics = function() {
  var replace, that;
  that = this;
  replace = function(diacritic) {
    return that = that.replace(rsc.diacritics[diacritic], diacritic);
  };
  Object.keys(rsc.diacritics).forEach(replace);
  return that;
};


/*
 * Retourne un objet qui dénombre les voyelles
 */

String.prototype.vowels = function() {
  var increment, vowels;
  vowels = {};
  increment = function(letter) {
    if (rsc.alphabet[letter].type === 'vowel') {
      return vowels[letter] = (vowels[letter] || 0) + 1;
    }
  };
  this.noDiacritics().split``.forEach(increment);
  return vowels;
};


/*
 * Retourne un objet qui dénombre les consonnes
 */

String.prototype.consonants = function() {
  var consonants, increment;
  consonants = {};
  increment = function(letter) {
    if (rsc.alphabet[letter].type === 'consonant') {
      return consonants[letter] = (consonants[letter] || 0) + 1;
    }
  };
  this.noDiacritics().split``.forEach(increment);
  return consonants;
};


/*
 * Retourne un tableau qui contient l'ensemble des
 * mots en français
 */

String.prototype.frenchWords = function() {
  return {
    simple: rsc.words_fr_no_diacritics.slice(0),
    diacritics: rsc.words_fr.slice(0)
  };
};


/*
 * TODO: CONTAINS
 */


/*
 * Retourne les mots français qui contiennent
 * les lettres contenues dans la chaîne
 */

String.prototype.guessFrench = function() {
  var containsLetter, that;
  that = this;
  containsLetter = function(word) {
    return !that.noDiacritics().split('').some(function(l) {
      return word.indexOf(l === -1);
    });
  };
  return String.prototype.frenchWords().simple.filter(containsLetter);
};
