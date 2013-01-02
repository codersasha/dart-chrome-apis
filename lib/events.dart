/* from events.json */
part of chrome;

/**
 * Description of a declarative rule for handling events.
 */
class Rule {
  /**
   * JS Object Representation
   */
  JSObject _jsObject;

  /**
   * Constructor
   */
  Rule(this._jsObject);

  /* Optional identifier that allows referencing this rule. */
  String get id => _jsObject.baseTypeMemberVariable('id');

  /* List of conditions that can trigger the actions. */
  List get conditions => _jsObject.baseTypeMemberVariable('conditions');

  /* List of actions that are triggered if one of the condtions is fulfilled. */
  List get actions => _jsObject.baseTypeMemberVariable('actions');

  /* Optional priority of this rule. Defaults to 100. */
  int get priority => _jsObject.baseTypeMemberVariable('priority');
}

/**
 * An object which allows the addition and removal of listeners for a Chrome event.
 *
 * All API events should extend from this class, and overwrite methods that take
 * Function objects to call these ones. This is to provide stronger types
 * on Function parameters.
 *
 * For example:
 *
 * class my_event extends __event {
 *   void addListener(void callback(int x, String y))
 *       => super.addListener(callback);
 *   void removeListener(void callback(int x, String y))
 *       => super.removeListener(callback);
 *   bool hasListener(void callback(int x, String y))
 *       => super.hasListener(callback);
 *
 *   my_event() :
 *       super(['app', 'runtime', 'onLaunched']);
 * }
 *
 */
class __event {

  /**
   * API connection
   */
  ChromeApi _api;

  /**
   * Create a new Event with the given path.
   */
  __event(List<String> path) {
    _api = new ChromeApi(path);
  }

  /**
   * Registers an event listener <em>callback</em> to an event.
   */
  void addListener(Function callback) {
    _api.voidFunctionCall('addListener', [
        callback
    ]);
  }

  /**
   * Deregisters an event listener <em>callback</em> from an event.
   */
  void removeListener(Function callback) {
    _api.voidFunctionCall('removeListener', [
        callback
    ]);
  }

  /**
   * Returns True if <em>callback</em> is registered to the event.
   */
  bool hasListener(Function callback) {
    return _api.baseTypeFunctionCall('hasListener', [
        callback
    ]);
  }

  /**
   * Returns true if any event listeners are registered to the event.
   */
  bool hasListeners() {
    return _api.baseTypeFunctionCall('hasListeners');
  }

  /**
   * Registers rules to handle events.
   *
   * @param eventName Name of the event this function affects.
   * @param rules Rules to be registered. These do not replace previously registered rules.
   * @param callback Called with registered rules.
   */
  void addRules(String eventName, List<Rule> rules, [ void callback(List<Rule> rules) ]) {

    // proxy for void callback(List<Rule> rules)
    void __proxied_callback(var rules) {};

    if (callback != null)
      void __proxied_callback(var rules) {
        List<Rule> __proxy_rules = new List<Rule>();

        js.scoped(() {
          for (int i = 0; i < rules.length; i ++) {
            __proxy_rules.add(new Rule(rules[i]));
          }
        });

        callback(__proxy_rules);
      }

    _api.voidFunctionCall('addRules', [
        eventName,
        rules,
        __proxied_callback
    ]);
  }

  /**
   * Returns currently registered rules.
   *
   * @param eventName Name of the event this function affects.
   * @param ruleIdentifiers If an array is passed, only rules with identifiers contained in this array are returned.
   * @param callback Called with registered rules.
   */
  void getRules(String eventName, [ List<String> ruleIdentifiers, void callback(List<Rule> rules) ]) {

    // proxy for void callback(List<Rule> rules)
    void __proxied_callback(var rules) {};

    if (callback != null)
      void __proxied_callback(var rules) {
        List<Rule> __proxy_rules = new List<Rule>();

        js.scoped(() {
          for (int i = 0; i < rules.length; i ++) {
            __proxy_rules.add(new Rule(rules[i]));
          }
        });

        callback(__proxy_rules);
      }

    _api.voidFunctionCall('addRules', [
        eventName,
        ruleIdentifiers,
        __proxied_callback
    ]);
  }

  /**
   * Unregisters currently registered rules.
   *
   * @param eventName Name of the event this function affects.
   * @param ruleIdentifiers If an array is passed, only rules with identifiers contained in this array are unregistered.
   * @param callback Called when rules were unregistered.
   */
  void removeRules(String eventName, [ List<String> ruleIdentifiers, void callback() ]) {
    _api.voidFunctionCall('addRules', [
        eventName,
        ruleIdentifiers,
        callback
    ]);
  }
}