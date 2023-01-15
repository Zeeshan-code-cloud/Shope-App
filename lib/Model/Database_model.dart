class Database_Model {
  late String img;
  late String name;
  late String oldprice;
  late String price;

  Database_Model(
      {required this.img,
        required this.name,
        required this.oldprice,
        required this.price});

  static Database_Model fromMap(Map<String, dynamic> map) {
    return Database_Model(
        img: map["Image"],
        name: map["name"],
        oldprice: map["old Price"],
        price: map["price"]);
  }
}
