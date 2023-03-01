import 'restaurant_model.dart';

class RestaurantResultModel {
  bool? error;
  String? message;
  int? count;
  int? founded;
  List<RestaurantModel>? restaurants;

  RestaurantResultModel(
      {this.error, this.message, this.count, this.founded, this.restaurants});

  RestaurantResultModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    count = json['count'];
    founded = json['founded'];
    if (json['restaurants'] != null) {
      restaurants = <RestaurantModel>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(RestaurantModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['count'] = count;
    data['founded'] = founded;
    if (restaurants != null) {
      data['restaurants'] = restaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
