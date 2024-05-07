import 'package:logging/logging.dart';

class MtmLogger {
  logEvent(LogRecord event) {
    throw UnimplementedError('log Event must be overriden');
  }

  String formatLogMessage(LogRecord event) {
    String message =
        '${event.loggerName} | ${event.time} | ${event.level.name} | ${event.message}';
    return message;
  }
}
