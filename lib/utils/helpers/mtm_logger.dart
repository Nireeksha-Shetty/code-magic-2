import 'package:logging/logging.dart';

// Wrapper for the logging package
class MtmLogger {
  static log({
    required String loggerName,
    required Level logLevel,
    String message = '',
  }) {
    Logger logger = Logger(loggerName);
    logger.log(logLevel, message);
  }
}
