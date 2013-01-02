/* from app_runtime.idl */
part of chrome;

/**
 * Types
 */

// A WebIntents intent object. Deprecated.
class Intent extends ChromeObject {
  // The WebIntent being invoked.
  String action;

  // The MIME type of the data.
  String type;

  // Data associated with the intent.
  var data;

  // Callback to be compatible with WebIntents.
  Function postResult;

  // Callback to be compatible with WebIntents.
  Function postFailure;

  /*
   * Constructor
   */
  Intent({
    this.action,
    this.type,
    this.data,
    void this.postResult(),
    void this.postFailure()
  });

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
}

class LaunchItem extends ChromeObject {
  // FileEntry for the file.
  html.FileEntry entry;

  // The MIME type of the file.
  String type;

  /*
   * Constructor
   */
  LaunchItem({
    this.entry,
    this.type
  });

  /*
   * Serialisation function
   */
  Map _toMap() {
    Map m = {};
    if (entry != null) m['entry'] = entry;
    if (type != null) m['type'] = type;
    return m;
  }
}

// Optional data for the launch.
class LaunchData extends ChromeObject {
  Intent intent;

  // The id of the file handler that the app is being invoked with.
  String id;

  List<LaunchItem> items;

  /*
   * Constructor
   */
  LaunchData({
    this.intent,
    this.id,
    this.items
  });

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
}

class IntentResponse extends ChromeObject {
  // Identifies the intent.
  int intentId;

  // Was this intent successful? (i.e., postSuccess vs postFailure).
  bool success;

  // Data associated with the intent response.
  var data;

  /*
   * Constructor
   */
  IntentResponse({this.intentId, this.success, this.data});

  /*
   * Serialisation method
   */
  Map _toMap() {
    return {
      'intentId': intentId,
      'success': success,
      'data': data
    };
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

