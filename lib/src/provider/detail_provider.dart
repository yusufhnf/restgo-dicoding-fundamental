import 'package:flutter/material.dart';

import '../data/local/favorite_local_datasource.dart';
import '../data/remote/restaurant_remote_datasource.dart';
import '../data/model/restaurant_model.dart';

enum DetailState { loading, success, error }

class DetailProvider extends ChangeNotifier {
  final RestaurantRemoteDataSource apiService;
  final String restaurantId;
  late FavoriteLocalDataSource _dbHelper;

  DetailProvider({required this.apiService, required this.restaurantId}) {
    _dbHelper = FavoriteLocalDataSource();
    fetchRestaurantData();
  }

  late RestaurantModel _restaurantResult;
  late DetailState _state;
  String _message = '';
  bool isFavorite = false;
  String get message => _message;

  RestaurantModel get result => _restaurantResult;
  DetailState get state => _state;

  Future<dynamic> fetchRestaurantData() async {
    try {
      _state = DetailState.loading;
      notifyListeners();

      final restaurantResult =
          await apiService.getRestaurantDetail(restaurantId: restaurantId);
      final restaurantData = restaurantResult.restaurant;
      if (restaurantData != null) {
        isFavorite = await _dbHelper.checkFavoriteStatus(restaurantData.id!);
        _state = DetailState.success;
        notifyListeners();
        return _restaurantResult = restaurantData;
      }
      _state = DetailState.error;
      notifyListeners();
    } catch (e) {
      _state = DetailState.error;
      notifyListeners();
      return _message = "Failed to get the data, please try again";
    }
  }

  Future updateFavorite() async {
    if (isFavorite) {
      _dbHelper.deleteFavoriteRestaurant(result);
    } else {
      _dbHelper.insertFavoriteRestaurant(result);
    }
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
