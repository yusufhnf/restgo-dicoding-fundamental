import 'restaurant_model.dart';

class RestaurantDetailResultModel {
  bool? error;
  String? message;
  RestaurantModel? restaurant;

  RestaurantDetailResultModel({this.error, this.message, this.restaurant});

  RestaurantDetailResultModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    restaurant = json['restaurant'] != null
        ? RestaurantModel.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }

    return data;
  }
}
