import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../functions/meal_functions.dart';
import '../../models/food_item.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final isAuthenticated = context.read<bool>();
  if (!isAuthenticated) {
    return Response(
      statusCode: 401,
      body: 'Unauthorized',
    );
  }


  final request = context.request;
  final params = request.uri.queryParameters;

  // DELETE request
  if (request.method == HttpMethod.delete) {
    deleteMeal(id);
    return Response(
      body: jsonEncode(mealsOfTheDay),
    );
  }

  // PUT request
  if (request.method == HttpMethod.put) {
    final requestBody = await request.body();
    final foodItemData = jsonDecode(requestBody) as Map<String, dynamic>;
    final modifiedFoodItem = FoodItem.fromJson(foodItemData);
    updateMeal(id, modifiedFoodItem);
    return Response(
      body: jsonEncode(mealsOfTheDay),
    );
  }

  // POST request
  if (request.method == HttpMethod.post) {
    final requestBody = await request.body();
    final foodItemData = jsonDecode(requestBody) as Map<String, dynamic>;
    final newFoodItem = FoodItem.fromJson(foodItemData);
    createMeal(newFoodItem);

    return Response(
      statusCode: 201,
      body: jsonEncode(mealsOfTheDay),
    );
  }
  // GET request
  if (request.method == HttpMethod.get) {
    if (id != '') {
      final foodItem = getMeal(id);
      if (foodItem != null) {
        return Response(
          body: jsonEncode(foodItem),
        );
      } else {
        return Response(
          statusCode: 404,
          body: jsonEncode('Not Found'),
        );
      }
    } else if (params.isNotEmpty) {
      final category = params['category'];
      if (category != null) {
        final categoryBasedFoodList = getFoodByCategory(category);
        return Response(
          body: jsonEncode(categoryBasedFoodList),
        );
      }
    }
  }

  return Response(
    body: jsonEncode(mealsOfTheDay),
  );
}
