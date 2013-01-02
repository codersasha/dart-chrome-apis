/**
 * A set of utilities for use with the Chrome Extension APIs.
 *
 * Allows for easy access to required JS objects.
 *
 */
part of chrome;

/**
 * A dart object, that is convertible to JS. Used for creating objects in dart,
 * then passing them to JS.
 *
 * Objects that are passable to JS need to implement this interface.
 */
abstract class ChromeObject {
  // Return a Map representation of this object,  (non-recursive).
  Map _toMap();
}

/**
 * A JS object, that is convertible to dart. Used for retrieving objects from JS,
 * then returning them to the user.
 *
 * Objects that are returned to the user can have these as a private member
 * variable to wrap API calls.
 */
class JSObject {
  // The JS object itself
  js.Proxy _jsObject;

  JSObject(this._jsObject);

  /**
   * A scoped function call in Javascript to the given function on the given
   * object with the given list of arguments. Does not return anything.
   *
   * Arguments are converted to maps & wrapped before the call.
   */
  void voidFunctionCall(String name, [ List arguments ]) {
    js.scoped(() {
      _jsObject.callMethod(name, ChromeApi._convertArgument(arguments));
    });
  }

  /**
   * A scoped function call in Javascript to the given function on the given
   * object with the given list of arguments. Returns a base type (string, num,
   * int, bool).
   *
   * Arguments are converted to maps & wrapped before the call.
   */
  Object baseTypeFunctionCall(String name, [ List arguments ]) {
    var __retval;

    js.scoped(() {
      __retval = _jsObject.callMethod(name, ChromeApi._convertArgument(arguments));
    });

    return __retval;
  }

  /**
   * A scoped function call in Javascript to the given function on the given
   * object with the given list of arguments. Returns a non-base type (generic
   * object Proxy) as a wrapped JSObject.
   *
   * Arguments are converted to maps & wrapped before the call.
   */
  JSObject objectFunctionCall(String name, [ List arguments ]) {
    var __retval;

    js.scoped(() {
      __retval = js.retain(_jsObject.callMethod(name, ChromeApi._convertArgument(arguments)));
    });

    return new JSObject(__retval);
  }

  /**
   * A scoped member variable resolve in Javascript. Returns a base type.
   */
  Object baseTypeMemberVariable(String name) {
    var __retval;
    js.scoped(() {
      __retval = _jsObject[name];
    });
    return __retval;
  }

  /**
   * A scoped member variable resolve in Javascript. Returns a JSObject proxy,
   * ready for wrapping with a custom class.
   */
  JSObject objectMemberVariable(String name, [ List arguments ]) {
    var __retval;
    js.scoped(() {
      __retval = js.retain(_jsObject[name]);
    });
    return new JSObject(__retval);
  }

  /**
   * A scoped member variable resolve in Javascript. Returns a generic Proxy object.
   * TODO(sashab): Memory leaks
   */
  js.Proxy genericProxyMemberVariable(String name) {
    js.$experimentalEnterScope();
    return _jsObject[name];
  }

}

/**
 * A connection to the chrome API, represented as a path to that API.
 *
 * Objects that need a connection to the Chrome API should have this as a static
 * variable.
 */
class ChromeApi {
  // a path of strings, representing the path to all functions
  // e.g. [app, window] means js.context.chrome.app.window
  List<String> _path;

  ChromeApi(this._path);

  /**
   * Converts the given map-type argument to js-friendly format, recursively.
   * Returns the new Map object.
   */
  static Map _convertMapArgument(Map argument) {
    Map m = new Map();
    for (Object key in argument.keys) {
      m[key] = _convertArgument(argument[key]);
    }
    return m;
  }

  /**
   * Converts the given list-type argument to js-friendly format, recursively.
   * Returns the new List object.
   */
  static List _convertListArgument(List argument) {
    List l = new List();
    for (var i = 0; i < argument.length; i ++) {
      l.add(_convertArgument(argument[i]));
    }
    return l;
  }

  /**
   * Converts the given arguments Object to js-friendly format, recursively.
   * Returns the new argument.
   */
  static Object _convertArgument(var argument) {
    var converted_argument;
    if (argument == null) {
      // null type
      converted_argument = argument;
    } else if (argument is num || argument is String || argument is bool) {
      // base type
      converted_argument = argument;
    } else if (argument is js.Proxy) {
      // already serialized
      converted_argument = argument;
    } else if (argument is ChromeObject) {
      // serializable object
      converted_argument = js.map(_convertMapArgument(argument._toMap()));
    } else if (argument is List) {
      // list
      converted_argument = _convertListArgument(argument);
    } else if (argument is Map) {
      // map
      converted_argument = js.map(_convertMapArgument(argument));
    } else if (argument is Function) {
      // function
      converted_argument = new js.Callback.many(argument);
    } else {
      // TODO: can't convert generic dart object; should throw exception here
      converted_argument = argument;
    }
    return converted_argument;
  }

  /**
   * A scoped function call in Javascript to the given function with the
   * given list of arguments. Does not return anything.
   *
   * Arguments are converted to maps & wrapped before the call.
   */
  void voidFunctionCall(String name, [ List arguments ]) {
    js.scoped(() {
      var __chain = js.context.chrome;
      for (String _opt in _path) {
        __chain = __chain[_opt];
      }

      __chain.callMethod(name, ChromeApi._convertArgument(arguments));
    });
  }

  /**
   * A scoped function call in Javascript to the given function with the
   * given list of arguments. Returns a base type (string, num, int, bool).
   *
   * Arguments are converted to maps & wrapped before the call.
   */
  Object baseTypeFunctionCall(String name, [ List arguments ]) {
    var __retval;

    js.scoped(() {
      var __chain = js.context.chrome;
      for (String _opt in _path) {
        __chain = __chain[_opt];
      }

      __retval = __chain.callMethod(name, _convertArgument(arguments));
    });

    return __retval;
  }

  /**
   * A scoped function call in Javascript to the given function with the
   * given list of arguments. Returns a non-base type (generic object Proxy)
   * as a wrapped JSObject.
   *
   * Arguments are converted to maps & wrapped before the call.
   */
  JSObject objectFunctionCall(String name, [ List arguments ]) {
    var __retval;

    js.scoped(() {
      var __chain = js.context.chrome;
      for (String _opt in _path) {
        __chain = __chain[_opt];
      }

      __retval = js.retain(__chain.callMethod(name, _convertArgument(arguments)));
    });

    return new JSObject(__retval);
  }
}

