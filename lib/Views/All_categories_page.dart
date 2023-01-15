import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tussi_shope/Views/Card_page.dart';
import '../Controllers/Product_utils.dart';
import 'Product_details.dart';
import 'Splash_screen.dart';

class all_categories_page extends StatefulWidget {
  const all_categories_page({super.key});

  @override
  State<all_categories_page> createState() => _all_categories_pageState();
}

class _all_categories_pageState extends State<all_categories_page> {
  final products = Product_Utils.product_list;
  final searchController = TextEditingController();
  User? user;
  DatabaseReference? Db_ref;

  final List<Widget> imagesList = [
    Stack(
      children: [
        Container(
          height: 350,
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: const DecorationImage(
                image: AssetImage("assets/images/six.jpg"),
                fit: BoxFit.cover,
              )),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Best Sale 70% off",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
    Stack(
      children: [
        Container(
          height: 350,
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: const DecorationImage(
                image: AssetImage("assets/images/eigth.jpg"),
                fit: BoxFit.cover,
              )),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Best Sale 70% off",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
    Stack(
      children: [
        Container(
          height: 350,
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: const DecorationImage(
                image: AssetImage("assets/images/harddisk.jpeg"),
                fit: BoxFit.cover,
              )),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Best Sale 70% off",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffffe7c7),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("confirmation meassage"),
                                content: const Text("Are you sure to Log out"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Splash_screen()));
                                      },
                                      child: const Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("No"))
                                ],
                              ));
                    },
                    icon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.78,
                    decoration: BoxDecoration(
                      color: const Color(0xfff9f9f9),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: "Search here",
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 3.0,
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffffe7c7),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const card_page()));
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_rounded),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            CarouselSlider(
                items: imagesList,
                options: CarouselOptions(
                    animateToClosest: true,
                    aspectRatio: 2,
                    height: 220,
                    viewportFraction: 0.75,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(seconds: 1))),
            const SizedBox(
              height: 22,
            ),



            const Padding(
              padding: EdgeInsets.only(left: 22.0),
              child: Text(
                "Features Products",
                style: TextStyle(
                  fontSize: 23,
                  color: Color(0xffa3c29a),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SafeArea(
                top: false,
                maintainBottomViewPadding: true,
                child: SingleChildScrollView(
                    child: SingleChildScrollView(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.979,
                      height: 700,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: const BoxDecoration(
                          color: Color(0xffffe7c7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 6),
                              color: Color.fromARGB(255, 17, 17, 17),
                            )
                          ]),
                      child: GridView.builder(
                          itemCount: Product_Utils.product_list.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.77,
                          ),
                          itemBuilder: (context, index) {
                            var product = products[index];
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    product_details_page(
                                                        imgurl: product.imgurl,
                                                        name: product.name,
                                                        oldprice: product.oldprice,
                                                        saleprice: product.saleprice)));
                                      },
                                      child: Container(
                                        height: 268,
                                        width: 220,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                blurRadius: 4,
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 12.0),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff3cb371),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                      blurRadius: 3.0,
                                                    )
                                                  ]),
                                              child: IconButton(
                                                onPressed: () async {
                                                  //request to database to stored the product data
                                                  User? user = FirebaseAuth.instance.currentUser;

                                                  if (user != null) {
                                                    String uid = user.uid;
                                                    String date = DateTime.now().millisecondsSinceEpoch.toString();
                                                    final user_Db = FirebaseDatabase.instance.reference().child("task").child(uid);
                                                    String task_id = user_Db.push().key.toString();

                                                    user_Db.child(task_id).set({
                                                      "name": product.name,
                                                      "price": product.saleprice,
                                                      "old Price": product.oldprice,
                                                      "Image": product.imgurl,
                                                    });
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.white,
                                                  size: 26,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff3cb371),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                      blurRadius: 3.0,
                                                    )
                                                  ]),
                                              child: IconButton(
                                                onPressed: () {
                                                  user = FirebaseAuth
                                                      .instance.currentUser;
                                                  if (user != null) {
                                                    Db_ref = FirebaseDatabase.instance.reference().child("favourite").child(user!.uid);
                                                    String Date = DateTime.now().millisecondsSinceEpoch.toString();
                                                    String Task_id = Db_ref!.push().key.toString();
                                                    Db_ref!.child(Task_id).set({
                                                      "name": product.name,
                                                      "image": product.imgurl,
                                                      "old price" : product.oldprice,
                                                      "price" : product.saleprice,
                                                    });
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.white,
                                                  size: 26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0,),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                                                        product_details_page(
                                                            imgurl: product.imgurl, name: product.name,
                                                            oldprice: product.oldprice, saleprice: product.saleprice)));
                                          },
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              width: 180,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          Product_Utils.product_list[index].imgurl), fit: BoxFit.cover)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 11.0,),
                                        Text(
                                          products[index].name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff3cc8b3),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 22.0,),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              products[index].saleprice,
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  color: Color(0xff08d799),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              products[index].oldprice,
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 19,
                                                  color: Color.fromARGB(
                                                      255, 129, 146, 141),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ]
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          }
                          )
                  ),
                )
                )
            ),
          ],
        ),
      )
      ),
    );
  }
}
