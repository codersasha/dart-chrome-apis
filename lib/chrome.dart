library chrome;
import '../packages/js/js.dart' as js;
import 'dart:html' as html;

part '_utils.dart';

part 'alarms.dart';
part 'events.dart';
part 'app_runtime.dart';
part 'app_window.dart';

/* parent of app_runtime & app_window */
class _app {
  _app_runtime runtime;
  _app_window window;

  _app() :
    runtime = new _app_runtime(),
    window = new _app_window()
  ;
}

/* parent of app */
class _chrome {
  _app app;
  _alarms alarms;

  _chrome() :
    app = new _app(),
    alarms = new _alarms()
  ;
}

_chrome chrome = new _chrome();
