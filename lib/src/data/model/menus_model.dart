class Menus {
  List<Foods>? foods;
  List<Foods>? drinks;

  Menus({this.foods, this.drinks});

  List<Foods> get getAllMenu {
    List<Foods> menus = [];
    menus.addAll(foods?.toList() ?? []);
    menus.addAll(drinks?.toList() ?? []);

    return menus;
  }

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Foods>[];
      json['drinks'].forEach((v) {
        drinks!.add(Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    if (drinks != null) {
      data['drinks'] = drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String? name;

  Foods({this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
