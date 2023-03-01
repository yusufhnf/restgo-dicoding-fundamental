import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../model/restaurant_detail_result_model.dart';
import '../model/restaurant_model.dart';
import '../model/restaurant_result_model.dart';

class RestaurantRemoteDataSource {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = '/list';
  static const String _detail = '/detail';
  static const String _search = '/search';
  static const String loadImage = '$_baseUrl/images/medium/';

  Future<RestaurantResultModel> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl$_list"));
    if (response.statusCode == 200) {
      return RestaurantResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Data');
    }
  }

  Future<RestaurantDetailResultModel> getRestaurantDetail(
      {required String restaurantId}) async {
    final response =
        await http.get(Uri.parse("$_baseUrl$_detail/$restaurantId"));
    if (response.statusCode == 200) {
      return RestaurantDetailResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Data');
    }
  }

  Future<RestaurantModel> getRandomRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl$_list"));
    if (response.statusCode == 200) {
      final random = Random();
      List<RestaurantModel> listRestaurant =
          RestaurantResultModel.fromJson(json.decode(response.body))
                  .restaurants ??
              [];
      RestaurantModel restaurant =
          listRestaurant[random.nextInt(listRestaurant.length)];
      return restaurant;
    } else {
      throw Exception('Failed to Load Data');
    }
  }

  Future<RestaurantResultModel> searchRestaurant({required String hint}) async {
    final response = await http.get(Uri.parse("$_baseUrl$_search?q=$hint"));
    if (response.statusCode == 200) {
      return RestaurantResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Data');
    }
  }
}
