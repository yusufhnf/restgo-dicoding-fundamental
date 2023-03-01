import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favourites/favorites_screen.dart';
import '../setting/setting_screen.dart';

import '../../data/remote/restaurant_remote_datasource.dart';
import '../search/search_screen.dart';
import '../shared_widgets/info_view.dart';
import '../shared_widgets/loading_view.dart';
import '../../provider/home_provider.dart';
import '../shared_widgets/food_tile.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("RestGo"),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(SearchScreen.routeName),
                icon: const Icon(Icons.search))
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.account_circle),
                ),
                accountName: Text('Yusuf Umar Hanafi'),
                accountEmail: Text('flyme.yusuf@gmail.com'),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(FavoritesScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Setting'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(SettingScreen.routeName);
                },
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider<HomeProvider>(
            create: (_) =>
                HomeProvider(apiService: RestaurantRemoteDataSource()),
            child: Consumer<HomeProvider>(builder: (context, state, _) {
              switch (state.state) {
                case HomeState.loading:
                  return const LoadingView();
                case HomeState.empty:
                  return InfoView(label: state.message);
                case HomeState.success:
                  return ListView.separated(
                    itemCount: state.result.length,
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (context, index) {
                      final restaurantData = state.result[index];
                      return FoodTile(restaurantData: restaurantData);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                case HomeState.error:
                  return InfoView(
                    label: state.message,
                    type: InfoType.error,
                    onTapAction: () => state.fetchRestaurantList(),
                  );
              }
            })));
  }
}
