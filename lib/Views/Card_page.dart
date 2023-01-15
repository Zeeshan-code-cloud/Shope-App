import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tussi_shope/Views/Main_page.dart';
import '../Model/Database_model.dart';

class card_page extends StatefulWidget {
  const card_page({super.key});

  @override
  State<card_page> createState() => _card_pageState();
}

class _card_pageState extends State<card_page> {
  User? user;
  DatabaseReference? Db_ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //to get the specific user tasks which are currently log in the system
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //to make the refferenc with the database to the specified locations
      Db_ref =  FirebaseDatabase.instance.reference().child("task").child(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainPage()));
        }, icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.blueGrey,)),
        title: const Text("My Wallet", style: TextStyle(color: Colors.blueGrey,fontSize: 22,fontWeight: FontWeight.bold),),
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
                child: CircularProgressIndicator(strokeWidth: 10),
              );
            }
            Map<String, dynamic> map = Map<String, dynamic>.from(snapshot2);

            var task_list = <Database_Model>[];
            for (var items in map.values) {
              Database_Model database_model =
                  Database_Model.fromMap(Map<String, dynamic>.from(items));
              task_list.add(database_model);
            }
            // var list_items = task_list[index];
            return ListView.builder(
              itemCount: task_list.length,
                itemBuilder: (context, index){
                var purchased_item = task_list[index];
              return Container(
                padding: EdgeInsets.only(top: 6,right: 2.0,left: 2.0),
                height: 100,
                child: Card(
                  child: ListTile(
                    leading: Container(
                      width:  150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(image: AssetImage(purchased_item.img),
                        fit: BoxFit.contain),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(purchased_item.name),
                        ElevatedButton(onPressed: (){}, child: const Text("Purchase"))
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Text(purchased_item.oldprice,style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
                        const SizedBox(height: 14.0,),
                        Text(purchased_item.price,style: const TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),),
                      ],
                    ),
                  ),
                ),
              );
            });
          }
         else{
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          }
        },
      ),
    );
  }
}
