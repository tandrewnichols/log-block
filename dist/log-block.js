(function() {
  var isNode = typeof module !== 'undefined' && this.module !== module;

  var isArray = Array.isArray || function(arr) {
    return toString.call(obj) === '[object Array]';
  };

  var isObject = function(obj) {
    return typeof obj === 'function' || typeof obj === 'object' && Boolean(obj);
  };

  var stringify = function(args) {
    for (var j = 0; j < args.length; j++) {
      if (isObject(args[j])) {
        args[j] = JSON.stringify(args[j]);
      }
    }
  };

  var log = function() {
    var args = [].slice.call(arguments);
    var hasArrays = args.some(function(arg) {
      return isArray(arg);
    });

    console.log();
    if (hasArrays) {
      for (var i = 0; i < args.length; i++) {
        stringify(args[i]);
        console.log.apply(console, ['   '].concat(args[i]));
      }
    } else {
      stringify(args);
      console.log.apply(console, ['   '].concat(args));
    }
    console.log();
  };

  /* istanbul ignore else */
  if (isNode) {
    module.exports = log;
  } else {
    window.logBlock = log;
  }
})();
