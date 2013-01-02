/* from app_window.idl */
part of chrome;

/**
 * Types
 */
class CreateWindowOptions extends ChromeObject {
  // Id to identify the window. This will be used to remember the size
  // and position of the window and restore that geometry when a window
  // with the same id (and no explicit size or position) is later opened.
  String id;

  // Default width of the window. (Deprecated; regular bounds act like this
  // now.)
  int defaultWidth;

  // Default height of the window. (Deprecated; regular bounds act like this
  // now.)
  int defaultHeight;

  // Default X coordinate of the window. (Deprecated; regular bounds act like
  // this now.)
  int defaultLeft;

  // Default Y coordinate of the window. (Deprecated; regular bounds act like
  // this now.)
  int defaultTop;

  // Width of the window. (Deprecated; use 'bounds'.)
  int width;

  // Height of the window. (Deprecated; use 'bounds'.)
  int height;

  // X coordinate of the window. (Deprecated; use 'bounds'.)
  int left;

  // Y coordinate of the window. (Deprecated; use 'bounds'.)
  int top;

  // Minimium width of the window.
  int minWidth;

  // Minimum height of the window.
  int minHeight;

  // Maximum width of the window.
  int maxWidth;

  // Maximum height of the window.
  int maxHeight;

  // Window type: 'shell' (the default) is the only currently supported value.
  String type;

  // Frame type: 'none' or 'chrome' (defaults to 'chrome').
  String frame;

  // Size of the content in the window (excluding the titlebar). If specified
  // in addition to any of the left/top/width/height parameters, this field
  // takes precedence. If a frameBounds is specified, the frameBounds take
  // precedence.
  Bounds bounds;

  // If true, the window will be created in a hidden state. Call show() on
  // the window to show it once it has been created. Defaults to false.
  bool hidden;

  CreateWindowOptions({
    this.id,
    this.defaultWidth,
    this.defaultHeight,
    this.defaultLeft,
    this.defaultTop,
    this.width,
    this.height,
    this.left,
    this.top,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.type,
    this.frame,
    this.bounds,
    this.hidden
  });

  Map _toMap() {
    Map m = {};
    if (id != null) m['id'] = id;
    if (defaultWidth != null) m['defaultWidth'] = defaultWidth;
    if (defaultHeight != null) m['defaultHeight'] = defaultHeight;
    if (defaultLeft != null) m['defaultLeft'] = defaultLeft;
    if (defaultTop != null) m['defaultTop'] = defaultTop;
    if (width != null) m['width'] = width;
    if (height != null) m['height'] = height;
    if (left != null) m['left'] = left;
    if (top != null) m['top'] = top;
    if (minWidth != null) m['minWidth'] = minWidth;
    if (minHeight != null) m['minHeight'] = minHeight;
    if (maxWidth != null) m['maxWidth'] = maxWidth;
    if (maxHeight != null) m['maxHeight'] = maxHeight;
    if (type != null) m['type'] = type;
    if (frame != null) m['frame'] = frame;
    if (bounds != null) m['bounds'] = bounds;
    if (hidden != null) m['hidden'] = hidden;
    return m;
  }
}

class Bounds extends ChromeObject {
  int left;
  int top;
  int width;
  int height;

  Bounds({this.left, this.top, this.width, this.height});

  Map _toMap() {
    return {
      'left': left,
      'top': top,
      'width': width,
      'height': height
    };
  }
}

class AppWindow {
  /**
   * JS Object Representation
   */
  JSObject _jsObject;

  /**
   * Constructor
   */
  AppWindow(this._jsObject);

  /**
   * Members (get only)
   */
  // The JavaScript 'window' object for the created child.
  // TODO: return actual window object - maybe using dart:html library
  //global get contentWindow;

  /**
   * Functions
   */
  // Focus the window.
  void focus() {
    _jsObject.voidFunctionCall('focus');
  }

  // Minimize the window.
  void minimize() {
    _jsObject.voidFunctionCall('minimize');
  }

  // Is the window minimized?
  bool isMinimized() {
    return _jsObject.baseTypeFunctionCall('isMinimized');
  }

  // Maximize the window.
  void maximize() {
    _jsObject.voidFunctionCall('maximize');
  }

  // Is the window maximized?
  bool isMaximized() {
    return _jsObject.baseTypeFunctionCall('isMaximized');
  }

  // Restore the window.
  void restore() {
    _jsObject.voidFunctionCall('restore');
  }

  // Move the window to the position (|left|, |top|).
  void moveTo(int left, int top) {
    _jsObject.voidFunctionCall('moveTo', [
        left,
        top
    ]);
  }

  // Resize the window to |width|x|height| pixels in size.
  void resizeTo(int width, int height) {
    _jsObject.voidFunctionCall('resizeTo', [
        width,
        height
    ]);
  }

  // Draw attention to the window.
  void drawAttention() {
    _jsObject.voidFunctionCall('drawAttention');
  }

  // Clear attention to the window.
  void clearAttention() {
    _jsObject.voidFunctionCall('clearAttention');
  }

  // Close the window.
  void close() {
    _jsObject.voidFunctionCall('close');
  }

  // Show the window. Does nothing if the window is already visible.
  void show() {
    _jsObject.voidFunctionCall('show');
  }

  // Hide the window. Does nothing if the window is already hidden.
  void hide() {
    _jsObject.voidFunctionCall('hide');
  }

  // Set the window's bounds.
  void setBounds(Bounds bounds) {
    _jsObject.voidFunctionCall('setBounds', [
        bounds
    ]);
  }
}

/**
 * Functions
 */
class _app_window {
  /**
   * API connection
   */
  ChromeApi _api = new ChromeApi(['app', 'window']);

  /**
   * Functions
   */
  // The size and position of a window can be specified in a number of
  // different ways. The most simple option is not specifying anything at
  // all, in which case a default size and platform dependent position will
  // be used.
  //
  // Another option is to use the top/left and width/height properties,
  // which will always put the window at the specified coordinates with the
  // specified size.
  //
  // Yet another option is to give the window a (unique) id. This id is then
  // used to remember the size and position of the window whenever it is
  // moved or resized. This size and position is then used instead of the
  // specified bounds on subsequent opening of a window with the same id. If
  // you need to open a window with an id at a location other than the
  // remembered default, you can create it hidden, move it to the desired
  // location, then show it.
  //
  // You can also combine these various options, explicitly specifying for
  // example the size while having the position be remembered or other
  // combinations like that. Size and position are dealt with seperately,
  // but individual coordinates are not. So if you specify a top (or left)
  // coordinate, you should also specify a left (or top) coordinate, and
  // similar for size.
  //
  // If you specify both a regular and a default value for the same option
  // the regular value is the only one that takes effect.
  void create(String url, [ CreateWindowOptions options, void callback(AppWindow created_window) ]) {
    _api.voidFunctionCall('create', [
        url,
        options,
        callback
     ]);
  }

  // Returns an <a href="#type-AppWindow">AppWindow</a> object for the
  // current script context (ie JavaScript 'window' object). This can also be
  // called on a handle to a script context for another page, for example:
  // otherWindow.chrome.app.window.current().
  AppWindow current() {
    return new AppWindow(
        _api.objectFunctionCall('current')
    );
  }

  void initializeAppWindow(Map state) {
    _api.voidFunctionCall('initializeAppWindow', [
        state
    ]);
  }

}