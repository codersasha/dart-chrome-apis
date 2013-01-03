/* from events.json */
part of chrome;

/**
 * Description of a declarative rule for handling events.
 */
class Rule extends ChromeObject {
  String _id;
  List _conditions;
  List _actions;
  int _priority;

  /*
   * Public constructor
   */
  Rule({
    String id,
    List conditions,
    List actions,
    int priority
  }) :
    _id = id,
    _conditions = conditions,
    _actions = actions,
    _priority = priority
  ;

  /*
   * Private constructor
   */
  Rule._proxy(JSObject _jsObject)
      : super._proxy(_jsObject);

  /*
   * Serialisation method
   */
  Map _toMap() {
    Map m = {};
    if (id != null) m['id'] = id;
    if (conditions != null) m['conditions'] = conditions;
    if (actions != null) m['actions'] = actions;
    if (priority != null) m['priority'] = priority;
    return m;
  }

  /*
   * Public accessors
   */
  String get id {
    if (!this._hasProxy())
      return this._id;
    return this._jsObject.baseTypeMemberVariable('id');
  }

  void set id(String id) {
    if (!this._hasProxy())
      this._id = id;
    else
      this._jsObject.setMemberVariable('id', id);
  }

  List get conditions {
    if (!this._hasProxy())
      return this._conditions;
    return this._jsObject.baseTypeMemberVariable('conditions');
  }

  void set conditions(List conditions) {
    if (!this._hasProxy())
      this._conditions = conditions;
    else
      this._jsObject.setMemberVariable('conditions', conditions);
  }

  List get actions {
    if (!this._hasProxy())
      return this._actions;
    return this._jsObject.baseTypeMemberVariable('actions');
  }

  void set actions(List actions) {
    if (!this._hasProxy())
      this._actions = actions;
    else
      this._jsObject.setMemberVariable('actions', actions);
  }

  int get priority {
    if (!this._hasProxy())
      return this._priority;
    return this._jsObject.baseTypeMemberVariable('priority');
  }

  void set priority(int priority) {
    if (!this._hasProxy())
      this._priority = priority;
    else
      this._jsObject.setMemberVariable('priority', priority);
  }

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
            __proxy_rules.add(new Rule._proxy(rules[i]));
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
            __proxy_rules.add(new Rule._proxy(rules[i]));
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