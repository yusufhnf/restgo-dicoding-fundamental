part of 'detail_screen.dart';

class _MenuView extends StatelessWidget {
  final List<Foods> menuData;

  const _MenuView({required this.menuData});

  @override
  Widget build(BuildContext context) {
    if (menuData.isEmpty) {
      return const InfoView(label: "Menu empty");
    }
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0),
      itemCount: menuData.length,
      itemBuilder: (context, index) {
        final Foods menu = menuData[index];
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.black12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: Icon(
                      Icons.restaurant_menu_outlined,
                      size: 38,
                      color: Colors.red,
                    )),
              ),
              const SizedBox(height: 10.0),
              Text(menu.name ?? "No name",
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black))
            ],
          ),
        );
      },
    );
  }
}
