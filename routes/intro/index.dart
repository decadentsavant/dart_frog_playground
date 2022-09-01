import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final file = await File(
    'views/index.html',
  ).readAsString();

  return Response(
    body: file,
    headers: {HttpHeaders.contentTypeHeader: ContentType.html.value},
  );
}
