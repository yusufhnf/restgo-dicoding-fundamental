import 'package:flutter/material.dart';
import '../helper/background_service_helper.dart';
import '../presentation/detail/detail_screen.dart';

import '../data/remote/restaurant_remote_datasource.dart';
import '../data/model/restaurant_model.dart';
import '../helper/notification_helper.dart';

enum HomeState { loading, empty, success, error }

class HomeProvider extends ChangeNotifier {
  final RestaurantRemoteDataSource apiService;
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundServiceHelper _service = BackgroundServiceHelper();

  HomeProvider({required this.apiService}) {
    _initial();
    fetchRestaurantList();
  }

  late List<RestaurantModel> _restaurantResult;
  late HomeState _state;
  String _message = '';
  String get message => _message;

  List<RestaurantModel> get result => _restaurantResult;
  HomeState get state => _state;

  void _initial() {
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
  }

  Future<dynamic> fetchRestaurantList() async {
    try {
      _state = HomeState.loading;
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.restaurants?.isEmpty ?? false) {
        _state = HomeState.empty;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = HomeState.success;
        notifyListeners();
        return _restaurantResult = restaurantList.restaurants ?? [];
      }
    } catch (e) {
      _state = HomeState.error;
      notifyListeners();
      return _message = "Failed to get the data, please try again";
    }
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
