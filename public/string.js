
/*
 * Chargement des ressources
 */
var rsc;

rsc = {};

rsc.priority = require('../rsc/letter_priority_fr.js');

rsc.diacritics = require('../rsc/diacritics.js');

rsc.alphabet = require('../rsc/alphabet.js');

rsc.words_fr = require('../rsc/words_fr.js');

rsc.words_fr_no_diacritics = require('../rsc/words_fr_no_diacritics.js');

rsc.words_fr_objectified = require('../rsc/words_fr_objectified.js');


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
      throw new Exception('Problème lors du chargement des ressources');
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
  this.noDiacritics().split('').forEach(increment);
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
  this.noDiacritics().split('').forEach(increment);
  return consonants;
};


/*
 * Retourne un tableau qui contient l'ensemble des
 * mots en français
 */

String.prototype.frenchWords = function() {
  return {
    simple: rsc.words_fr_no_diacritics.slice(0),
    diacritics: rsc.words_fr.slice(0),
    objectified: rsc.words_fr_objectified.slice(0)
  };
};


/*
 * Retourne les mots français qui contiennent
 * les lettres contenues dans la chaîne
 */

String.prototype.guessFrench = function() {
  var candidate, populateIfContained, suggestions;
  candidate = this.noDiacritics().objectify();
  suggestions = [];
  populateIfContained = function(word, index) {
    var cutOff;
    cutOff = candidate.length > word.length;
    if (cutOff) {

    } else if (word.contains(candidate)) {
      return suggestions.push(String.prototype.frenchWords().diacritics[index]);
    }
  };
  String.prototype.frenchWords().objectified.forEach(populateIfContained);
  return suggestions;
};
