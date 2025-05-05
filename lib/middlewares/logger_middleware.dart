import 'package:darto/darto.dart';

void loggerMiddleware(Request request, Response response, Next next) {
  print(
    '[${request.method} ${request.baseUrl}${request.path} - ${DateTime.now()}]',
  );
  next();
}
