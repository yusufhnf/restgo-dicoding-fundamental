import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/favorite_provider.dart';
import '../shared_widgets/food_tile.dart';
import '../shared_widgets/info_view.dart';
import '../shared_widgets/loading_view.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favourites';

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(),
          child: Consumer<FavoriteProvider>(builder: (context, state, _) {
            switch (state.state) {
              case FavoriteState.loading:
                return const LoadingView();
              case FavoriteState.empty:
                return InfoView(label: state.message);
              case FavoriteState.success:
                return ListView.separated(
                  itemCount: state.favouriteRestaurant.length,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (context, index) {
                    final restaurantData = state.favouriteRestaurant[index];
                    return FoodTile(
                      restaurantData: restaurantData,
                      callback: () => state.getAllRestaurants(),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              case FavoriteState.error:
                return InfoView(
                  label: state.message,
                  type: InfoType.error,
                );
            }
          })),
    );
  }
}
