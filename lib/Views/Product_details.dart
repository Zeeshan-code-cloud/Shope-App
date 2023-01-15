import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Controllers/Product_utils.dart';
import 'Main_page.dart';

class product_details_page extends StatefulWidget {
  late String name;
  late String imgurl;
  late String oldprice;
  late String saleprice;
  product_details_page(
      {super.key,
        required this.imgurl,
        required this.name,
        required this.oldprice,
        required this.saleprice});

  @override
  State<product_details_page> createState() => _product_details_pageState();
}

class _product_details_pageState extends State<product_details_page> {
  final Data = Product_Utils.product_list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 33,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.imgurl), fit: BoxFit.contain),
              ),
            ),
            Container(
                height: 450,
                width: MediaQuery.of(context).size.width * 0.984,
                margin: const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: Color(0xffffbfbc),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                      topRight: Radius.circular(150)),
                ),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 42, color: Color(0xff3c3c3c)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "old price ",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 22,
                                color: Color.fromARGB(255, 179, 168, 168)),
                          ),
                          Text(
                            widget.oldprice,
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color.fromARGB(255, 165, 155, 155),
                                fontSize: 22),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "sale price ",
                            style: TextStyle(
                                fontSize: 22, color: Color(0xff3c3c3c)),
                          ),
                          Text(
                            widget.saleprice,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.white,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            "Description",
                            style: const TextStyle(
                                color: Color(0xff3c3c3c),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const Text(
                            """is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries""",
                            style: TextStyle(color: Color(0xff3c3c3c)),
                          ),
                          const SizedBox(
                            height: 36.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10.0),
                                width: 200,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffbfbc),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Color(0xffffffff),
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          child: Center(
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      value--;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.minimize)))),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Color(0xffffffff),
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              value.toString(),
                                              style: const TextStyle(
                                                  fontSize: 23,
                                                  color: Color(0xff3c3c3c)),
                                            ),
                                          )),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    value++;
                                                  });
                                                },
                                                icon: const Icon(Icons.add))),
                                      ),
                                    ]),
                              ),
                              Container(
                                width: 100,
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23)),
                                child: IconButton(
                                  onPressed: () {
                                    //request to database to stored the product data
                                    User? user = FirebaseAuth.instance.currentUser;

                                    if (user != null) {
                                      String uid = user.uid;
                                      String date = DateTime.now().millisecondsSinceEpoch.toString();
                                      final user_Db = FirebaseDatabase.instance.reference().child("task").child(uid);
                                      String task_id = user_Db.push().key.toString();

                                      user_Db.child(task_id).set({
                                        "name": widget.name,
                                        "price": widget.saleprice,
                                        "old Price": widget.oldprice,
                                        "Image": widget.imgurl,
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                      Icons.shopping_cart_checkout_outlined,
                                      size: 55,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ));
  }

  int value = 0;
}
