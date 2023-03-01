import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/remote/restaurant_remote_datasource.dart';
import '../../provider/search_provider.dart';
import '../shared_widgets/food_tile.dart';
import '../shared_widgets/info_view.dart';
import '../shared_widgets/loading_view.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ChangeNotifierProvider<SearchProvider>(
          create: (_) =>
              SearchProvider(apiService: RestaurantRemoteDataSource()),
          child: Consumer<SearchProvider>(builder: (context, state, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: state.searchController,
                    onChanged: (_) => state.onSearchInput(),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                Expanded(child: _searchBuilder(state: state))
              ],
            );
          })),
    );
  }

  Widget _searchBuilder({required SearchProvider state}) {
    switch (state.state) {
      case SearchState.idle:
        return const SizedBox.expand();
      case SearchState.empty:
        return InfoView(label: state.message);
      case SearchState.loading:
        return const LoadingView();
      case SearchState.success:
        return ListView.separated(
          itemCount: state.result.length,
          padding: const EdgeInsets.all(20.0),
          itemBuilder: (context, index) {
            final restaurantData = state.result[index];
            return FoodTile(restaurantData: restaurantData);
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      case SearchState.error:
        return InfoView(
          label: state.message,
          type: InfoType.error,
          onTapAction: () => state.fetchRestaurantList(),
        );
    }
  }
}
