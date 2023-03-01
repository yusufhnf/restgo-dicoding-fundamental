import 'dart:async';

import 'package:flutter/material.dart';
import '../data/remote/restaurant_remote_datasource.dart';
import '../data/model/restaurant_model.dart';

enum SearchState { idle, loading, empty, success, error }

class SearchProvider extends ChangeNotifier {
  final RestaurantRemoteDataSource apiService;
  final TextEditingController searchController = TextEditingController();

  SearchProvider({required this.apiService});

  List<RestaurantModel> _restaurantResult = [];
  SearchState _state = SearchState.idle;
  Timer? _debounce;
  String _message = '';
  String get message => _message;

  List<RestaurantModel> get result => _restaurantResult;
  SearchState get state => _state;

  void onSearchInput() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (searchController.text.isEmpty) {
        _state = SearchState.idle;
        notifyListeners();
      } else {
        fetchRestaurantList();
      }
    });
  }

  Future<dynamic> fetchRestaurantList() async {
    try {
      _state = SearchState.loading;
      notifyListeners();

      final restaurantList =
          await apiService.searchRestaurant(hint: searchController.text);
      if (restaurantList.restaurants?.isEmpty ?? false) {
        _state = SearchState.empty;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = SearchState.success;
        notifyListeners();
        return _restaurantResult = restaurantList.restaurants ?? [];
      }
    } catch (e) {
      _state = SearchState.error;
      notifyListeners();
      return _message = "Failed to get the data, please try again";
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
