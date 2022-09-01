import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

// Load secret outside the middleware
final dotEnv = DotEnv()..load();
final secret = dotEnv['JWT_SECRET'] ?? '';

Handler middleware(Handler handler) {
  // handler returns true if the JWT token is valid, else false
  return handler.use(
    provider<bool>((context) {
      final request = context.request;
      // retrieve login information and auth type
      final headerData = request.headers;
      final authData = headerData['authorization'];
      final authType = getAuthType(authData.toString());

      // if auth type is JWT token type, verify token and
      // using dependency injection return true for verified,
      // else false
      if (authType == 'Bearer') {
        // get the token using the auth header data
        final receivedToken = getToken(authData.toString());
        try {
          // return true if verified token
          verifyJwtHS256Signature(receivedToken, secret);
          return true;
        } on JwtException {
          return false;
        }
      }
      return false;
    }),
  );
}

// helper functions
String getAuthType(String loginString) {
  final loginDetails = loginString.split(' ');
  return loginDetails[0];
}

String getToken(String loginString) {
  final loginDetails = loginString.split(' ');
  return loginDetails[1];
}
