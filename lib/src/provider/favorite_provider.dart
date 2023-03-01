import 'package:flutter/foundation.dart';
import '../data/local/favorite_local_datasource.dart';
import '../data/model/restaurant_model.dart';

enum FavoriteState { loading, success, empty, error }

class FavoriteProvider extends ChangeNotifier {
  late FavoriteState _state;
  List<RestaurantModel> _favouriteRestaurant = [];
  late FavoriteLocalDataSource _dbHelper;
  String _message = '';

  List<RestaurantModel> get favouriteRestaurant => _favouriteRestaurant;
  FavoriteState get state => _state;
  String get message => _message;

  FavoriteProvider() {
    _dbHelper = FavoriteLocalDataSource();
    getAllRestaurants();
  }

  Future getAllRestaurants() async {
    try {
      _state = FavoriteState.loading;
      notifyListeners();

      final restaurantResult = await _dbHelper.getFavoriteRestaurant();
      if (restaurantResult.isNotEmpty) {
        _state = FavoriteState.success;
        notifyListeners();
        return _favouriteRestaurant = restaurantResult;
      } else {
        _state = FavoriteState.empty;
        notifyListeners();
        return _message = "Data Empty";
      }
    } catch (e) {
      _state = FavoriteState.error;
      notifyListeners();
      return _message = "Failed to get the data, please try again";
    }
  }
}
