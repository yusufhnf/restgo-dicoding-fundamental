import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/menus_model.dart';
import '../../data/model/restaurant_model.dart';
import '../../data/remote/restaurant_remote_datasource.dart';
import '../../provider/detail_provider.dart';
import '../shared_widgets/icon_label.dart';
import '../shared_widgets/info_view.dart';
import '../shared_widgets/loading_view.dart';

part '_description_view.dart';
part '_menu_view.dart';
part '_review_view.dart';
part 'components/_sliver_app_bar_delegate.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  final String restaurantData;
  const DetailScreen({super.key, required this.restaurantData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(
          apiService: RestaurantRemoteDataSource(),
          restaurantId: restaurantData),
      child: Consumer<DetailProvider>(builder: (context, state, _) {
        return Scaffold(
          appBar: state.state == DetailState.error
              ? AppBar(
                  title: const Text("Detail"),
                  centerTitle: true,
                )
              : null,
          floatingActionButton: FloatingActionButton(
            onPressed: () => state.updateFavorite(),
            child: Icon(
                state.isFavorite ? Icons.favorite : Icons.favorite_outline),
          ),
          body: _bodyBuilder(state),
        );
      }),
    );
  }

  Widget _bodyBuilder(DetailProvider state) {
    switch (state.state) {
      case DetailState.loading:
        return const LoadingView();
      case DetailState.success:
        return DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: Colors.red.shade900,
                snap: true,
                pinned: true,
                floating: true,
                expandedHeight: 200.0,
                title: const Text("Detail"),
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    "${RestaurantRemoteDataSource.loadImage}${state.result.pictureId}",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child: const Icon(
                          Icons.restaurant_outlined,
                          color: Colors.white,
                          size: 48,
                        )),
                  ),
                  collapseMode: CollapseMode.pin,
                ),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(const TabBar(
                    indicatorColor: Colors.amber,
                    indicatorWeight: 5,
                    tabs: [
                      Tab(
                        text: "DESCRIPTION",
                      ),
                      Tab(
                        text: "MENU",
                      ),
                      Tab(
                        text: "REVIEW",
                      ),
                    ],
                  ))),
            ],
            body: TabBarView(
              children: [
                _DescriptionView(restaurantsData: state.result),
                _MenuView(
                  menuData: state.result.menus?.getAllMenu ?? [],
                ),
                _ReviewView(reviewData: state.result.customerReviews ?? [])
              ],
            ),
          ),
        );
      case DetailState.error:
        return InfoView(
          label: state.message,
          type: InfoType.error,
          onTapAction: () => state.fetchRestaurantData(),
        );
    }
  }
}
