import 'package:flutter_test/flutter_test.dart';
import 'package:restgo/src/data/model/restaurant_model.dart';

var testRestaurant = {
  "id": "id1234",
  "name": "CupCup Cafe",
  "description": "Karen Dinner minder sama cafe kita",
  "pictureId": "25",
  "city": "Lamongan",
  "rating": 5
};

var testReview = {
  "name": "Johan",
  "review": "Mantap Djiwa",
  "date": "20022022"
};
void main() {
  group("Parsing test", () {
    test("Restaurant Parsing Test", () async {
      var result = RestaurantModel.fromJson(testRestaurant).id;

      expect(result, "id1234");
    });

    test("Review Parsing Test", () async {
      var result = CustomerReviews.fromJson(testReview).name;

      expect(result, "Johan");
    });
  });
}
