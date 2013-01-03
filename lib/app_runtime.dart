/* from app_runtime.idl */
part of chrome;

/**
 * Types
 */

// A WebIntents intent object. Deprecated.
class Intent extends ChromeObject {
  // The WebIntent being invoked.
  String _action;

  // The MIME type of the data.
  String _type;

  // Data associated with the intent.
  var _data;

  // Callback to be compatible with WebIntents.
  Function _postResult;

  // Callback to be compatible with WebIntents.
  Function _postFailure;

  /*
   * Public constructor
   */
  Intent({
    String action,
    String type,
    var data,
    Function postResult,
    Function postFailure
  }) :
    _action = action,
    _type = type,
    _data = data,
    _postResult = postResult,
    _postFailure = postFailure
  ;

  /*
   * Private constructor
   */
  Intent._proxy(JSObject _jsObject)
      : super._proxy(_jsObject);

  /*
   * Serialisation method
   */
  Map _toMap() {
    Map m = {};
    if (action != null) m['action'] = action;
    if (type != null) m['type'] = type;
    if (data != null) m['data'] = data;
    if (postResult != null) m['postResult'] = postResult;
    if (postFailure != null) m['postFailure'] = postFailure;
    return m;
  }

  /*
   * Public accessors
   */
  String get action {
    if (!this._hasProxy())
      return this._action;
    return this._jsObject.baseTypeMemberVariable('action');
  }

  void set action(String action) {
    if (!this._hasProxy())
      this._action = action;
    else
      this._jsObject.setMemberVariable('action', action);
  }

  String get type {
    if (!this._hasProxy())
      return this._type;
    return this._jsObject.baseTypeMemberVariable('type');
  }

  void set type(String type) {
    if (!this._hasProxy())
      this._type = type;
    else
      this._jsObject.setMemberVariable('type', type);
  }

  Object get data {
    if (!this._hasProxy())
      return this._data;
    return this._jsObject.genericProxyMemberVariable('data');
  }

  void set data(var data) {
    if (!this._hasProxy())
      this._data = data;
    else
      this._jsObject.setMemberVariable('data', data);
  }

  /*
   * TODO(sashab): How to return function objects from JS? Invocation causes
   * "Illegal invocation".
   */
  Function get postResult {
    if (!this._hasProxy())
      return this._postResult;
    return this._jsObject.genericProxyMemberVariable('postResult');
  }

  void set postResult(Function postResult) {
    if (!this._hasProxy())
      this._postResult = postResult;
    else
      this._jsObject.setMemberVariable('postResult', postResult);
  }

  Function get postFailure {
    if (!this._hasProxy())
      return this._postFailure;
    return this._jsObject.genericProxyMemberVariable('postFailure');
  }

  void set postFailure(Function postFailure) {
    if (!this._hasProxy())
      this._postFailure = postFailure;
    else
      this._jsObject.setMemberVariable('postFailure', postFailure);
  }

}

class LaunchItem extends ChromeObject {
  // FileEntry for the file.
  html.FileEntry _entry;

  // The MIME type of the file.
  String _type;

  /*
   * Public constructor
   */
  LaunchItem({
    html.FileEntry entry,
    String type
  }) :
    _entry = entry,
    _type = type
  ;

  /*
   * Private constructor
   */
  LaunchItem._proxy(JSObject _jsObject)
      : super._proxy(_jsObject);

  /*
   * Serialisation method
   */
  Map _toMap() {
    Map m = {};
    if (entry != null) m['entry'] = entry;
    if (type != null) m['type'] = type;
    return m;
  }

  /*
   * Public accessors
   */
  /* TODO(sashab): Find a way to cast to html.FileEntry. */
  html.FileEntry get entry {
    if (!this._hasProxy())
      return this._entry;
    return this._jsObject.genericProxyMemberVariable('entry');
  }

  /* TODO(sashab): Find a way to serialize a html.FileEntry. */
  void set entry(html.FileEntry entry) {
    if (!this._hasProxy())
      this._entry = entry;
    else
      this._jsObject.setMemberVariable('entry', entry);
  }

  String get type {
    if (!this._hasProxy())
      return this._type;
    return this._jsObject.baseTypeMemberVariable('type');
  }

  void set type(String type) {
    if (!this._hasProxy())
      this._type = type;
    else
      this._jsObject.setMemberVariable('type', type);
  }


}

// Optional data for the launch.
class LaunchData extends ChromeObject {
  Intent _intent;

  // The id of the file handler that the app is being invoked with.
  String _id;

  List<LaunchItem> _items;

  /*
   * Public constructor
   */
  LaunchData({
    Intent intent,
    String id,
    List<LaunchItem> items
  }) :
    _intent = intent,
    _id = id,
    _items = items
  ;

  /*
   * Private constructor
   */
  LaunchData._proxy(JSObject _jsObject)
      : super._proxy(_jsObject);

  /*
   * Serialisation method
   */
  Map _toMap() {
    Map m = {};
    if (intent != null) m['intent'] = intent;
    if (id != null) m['id'] = id;
    if (items != null) m['items'] = items;
    return m;
  }

  /*
   * Public accessors
   */
  Intent get intent {
    if (!this._hasProxy())
      return this._intent;
    return new Intent._proxy(this._jsObject.objectMemberVariable('intent'));
  }

  void set intent(Intent intent) {
    if (!this._hasProxy())
      this._intent = intent;
    else
      this._jsObject.setMemberVariable('intent', intent);
  }

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

  /* TODO(sashab): Wrap lists of custom types when returning. */
  List<LaunchItem> get items {
    if (!this._hasProxy())
      return this._items;
    return this._jsObject.genericProxyMemberVariable('items');
  }

  void set items(List<LaunchItem> items) {
    if (!this._hasProxy())
      this._items = items;
    else
      this._jsObject.setMemberVariable('items', items);
  }
}

class IntentResponse extends ChromeObject {
  // Identifies the intent.
  int _intentId;

  // Was this intent successful? (i.e., postSuccess vs postFailure).
  bool _success;

  // Data associated with the intent response.
  Object _data;

  /*
   * Public constructor
   */
  IntentResponse({
    int intentId,
    bool success,
    Object data
  }) :
    _intentId = intentId,
    _success = success,
    _data = data
  ;

  /*
   * Private constructor
   */
  IntentResponse._proxy(JSObject _jsObject)
      : super._proxy(_jsObject);

  /*
   * Serialisation method
   */
  Map _toMap() {
    Map m = {};
    if (intentId != null) m['intentId'] = intentId;
    if (success != null) m['success'] = success;
    if (data != null) m['data'] = data;
    return m;
  }

  /*
   * Public accessors
   */
  int get intentId {
    if (!this._hasProxy())
      return this._intentId;
    return this._jsObject.baseTypeMemberVariable('intentId');
  }

  void set intentId(int intentId) {
    if (!this._hasProxy())
      this._intentId = intentId;
    else
      this._jsObject.setMemberVariable('intentId', intentId);
  }

  bool get success {
    if (!this._hasProxy())
      return this._success;
    return this._jsObject.baseTypeMemberVariable('success');
  }

  void set success(bool success) {
    if (!this._hasProxy())
      this._success = success;
    else
      this._jsObject.setMemberVariable('success', success);
  }

  Object get data {
    if (!this._hasProxy())
      return this._data;
    return this._jsObject.genericProxyMemberVariable('data');
  }

  void set data(var data) {
    if (!this._hasProxy())
      this._data = data;
    else
      this._jsObject.setMemberVariable('data', data);
  }
}

/**
 * Events
 */

// Fired when an app is launched from the launcher or in response to a web
// intent.
class _app_runtime_onlaunched extends __event {
  /*
   * Override callback type definitions
   */
  void addListener(void callback([LaunchData launchData]))
      => super.addListener(callback);
  void removeListener(void callback([LaunchData launchData]))
      => super.removeListener(callback);
  bool hasListener(void callback([LaunchData launchData]))
      => super.hasListener(callback);

  /*
   * Constructor
   */
  _app_runtime_onlaunched() :
    super(['app', 'runtime', 'onLaunched'])
  ;
}

// Fired at Chrome startup to apps that were running when Chrome last shut
// down.
class _app_runtime_onrestarted extends __event {
  /*
   * Override callback type definitions
   */
  void addListener(void callback())
      => super.addListener(callback);
  void removeListener(void callback())
      => super.removeListener(callback);
  bool hasListener(void callback())
      => super.hasListener(callback);

  /*
   * Constructor
   */
  _app_runtime_onrestarted() :
    super(['app', 'runtime', 'onRestarted'])
  ;
}

/**
 * Functions
 */
class _app_runtime {

  /*
   * API connection
   */
  ChromeApi api;

  /*
   * Events
   */
  _app_runtime_onlaunched onLaunched;
  _app_runtime_onrestarted onRestarted;

  /*
   * Functions
   */
  void postIntentResponse(IntentResponse intentResponse) {
    api.voidFunctionCall('postIntentResponse', [
        intentResponse
    ]);
  }

  /*
   * Constructor
   */
  _app_runtime() :
    api = new ChromeApi(['app', 'runtime']),
    onLaunched = new _app_runtime_onlaunched(),
    onRestarted = new _app_runtime_onrestarted()
    ;
}

