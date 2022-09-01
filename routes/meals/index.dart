import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import '../../models/food_item.dart';

Response onRequest(RequestContext context) {
  return Response(
    body: jsonEncode(mealsOfTheDay),
  );
}
