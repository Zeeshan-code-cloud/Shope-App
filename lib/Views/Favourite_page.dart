import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tussi_shope/Model/Database_model.dart';
import 'package:tussi_shope/Model/favourite_model.dart';

class favourite_page extends StatefulWidget {
  const favourite_page({super.key});

  @override
  State<favourite_page> createState() => _favourite_pageState();
}

class _favourite_pageState extends State<favourite_page> {
  User? user;
  DatabaseReference? Db_ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Db_ref = FirebaseDatabase.instance
          .reference()
          .child("favourite")
          .child(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite items", style: TextStyle(color: Colors.blueGrey,fontSize: 22,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream: Db_ref != null ? Db_ref!.onValue : null,
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              var event = snapshot.data as Event;
              var snapshot2 = event.snapshot.value;
              if (snapshot2 == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              }
              Map<String, dynamic> map = Map<String, dynamic>.from(snapshot2);
              var list = <dynamic>[];
              list.clear();
              for (var items in map.values) {
                Favourite_model favourite_model =
                    Favourite_model.fromMap(Map<String, dynamic>.from(items));
                list.add(favourite_model);
              }
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    var purchased_item = list[index];
                    return Container(
                      padding: EdgeInsets.only(top: 6, right: 2.0, left: 2.0),
                      height: 100,
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                  image: AssetImage(purchased_item.img),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          title: Text(purchased_item.name),
                          trailing: Column(
                            children: [
                              Text(
                                purchased_item.oldprice,
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 14.0,
                              ),
                              Text(
                                purchased_item.price,
                                style: const TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          }),
    );
  }
}
