class Favourite_model {
  late String img;
  late String name;
  late String oldprice;
  late String price;

  Favourite_model(
      {required this.img,
        required this.name,
        required this.oldprice,
        required this.price});

  static Favourite_model fromMap(Map<String, dynamic> map) {
    return Favourite_model(
        img: map["image"],
        name: map["name"],
        oldprice: map["old price"],
        price: map["price"]);
  }
}
