import 'package:flutter/material.dart';

import '../../data/remote/restaurant_remote_datasource.dart';
import '../../data/model/restaurant_model.dart';
import '../detail/detail_screen.dart';
import 'icon_label.dart';

class FoodTile extends StatelessWidget {
  final RestaurantModel restaurantData;
  final Function()? callback;
  const FoodTile({super.key, required this.restaurantData, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context)
            .pushNamed(DetailScreen.routeName, arguments: restaurantData.id)
            .then((_) {
          callback?.call();
        });
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              "${RestaurantRemoteDataSource.loadImage}${restaurantData.pictureId}",
              width: 80,
              height: 80,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                    color: Colors.grey,
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              },
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.red,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.restaurant_outlined,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurantData.name ?? "No name",
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              IconLabel(
                  leftIcon: Icon(
                    Icons.location_on,
                    color: Colors.red.shade900,
                  ),
                  label: restaurantData.city ?? "-"),
              IconLabel(
                  leftIcon: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  label: restaurantData.rating.toString()),
            ],
          ))
        ],
      ),
    );
  }
}
