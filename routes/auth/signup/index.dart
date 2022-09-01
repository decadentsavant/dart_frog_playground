import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:uuid/uuid.dart';

import '../../../models/models.dart';

String _hashPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  // store the salt witht the hash separated by a period
  return hash.toString();
}

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  if (request.method == HttpMethod.post) {
    final requestBody = await request.body();
    final userData = jsonDecode(requestBody) as Map<String, dynamic>;

    final user = User.fromJson(userData);
    user
      ..password = _hashPassword(user.password)
      ..id = const Uuid().v1();

    users.add(user);

    final claimSet = JwtClaim(
      issuer: user.id,
      subject: user.id,
    );

    final dotEnv = DotEnv()..load();
    final secret = dotEnv['JWT_SECRET'];

    return Response(
      body: jsonEncode(
        issueJwtHS256(
          claimSet,
          secret.toString(),
        ),
      ),
    );
  }

  return Response(
    statusCode: 400,
    body: 'Incorrect request method',
  );
}
