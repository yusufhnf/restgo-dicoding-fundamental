part of 'detail_screen.dart';

class _ReviewView extends StatelessWidget {
  final List<CustomerReviews> reviewData;

  const _ReviewView({required this.reviewData});

  @override
  Widget build(BuildContext context) {
    if (reviewData.isEmpty) {
      return const InfoView(label: "Review empty");
    }
    return ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, index) {
          final review = reviewData[index];
          return ListTile(
            title: Text(review.name ?? "-"),
            subtitle: Text(review.review ?? ""),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: reviewData.length);
  }
}
