part of 'detail_screen.dart';

class _DescriptionView extends StatelessWidget {
  final RestaurantModel restaurantsData;
  const _DescriptionView({required this.restaurantsData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Text(
          restaurantsData.name ?? "No name",
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5.0),
        IconLabel(
            leftIcon: Icon(
              Icons.location_on,
              color: Colors.red.shade900,
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
            label: restaurantsData.city ?? "-"),
        const SizedBox(height: 5.0),
        IconLabel(
            leftIcon: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
            label: restaurantsData.rating.toString()),
        const SizedBox(height: 10.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Description"),
          subtitle: Text(restaurantsData.description ?? "-"),
        )
      ],
    );
  }
}
