import 'package:expenser/dialog/credit.dart';
import 'package:expenser/dialog/debit.dart';
import 'package:expenser/history.dart';
import 'package:expenser/model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("EXPENSER"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                height: 75,
                padding: EdgeInsets.all(2),
                child: DrawerHeader(
                  child: Text('EXPENSER',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Credit"),
                onTap: () {
                  showDialog(
                    barrierColor: Colors.black.withOpacity(0.5),
                    barrierDismissible: true,
                    context: context,
                    builder: (_) => CreDialog(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text("Debit"),
                onTap: () {
                  showDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      barrierDismissible: true,
                      context: context,
                      builder: (_) => DebDialog());
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.card_membership),
                title: Text("History"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
                  // Update the state of the app.
                  // ...
                },
              ),
              //  ListTile(
              //   leading: Icon(Icons.people),
              //   title: Text("About us"),
              //   onTap: () {
              //     // Update the state of the app.
              //     // ...
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.play_circle_fill),
              //   title: Text("Our Apps"),
              //   onTap: () {
              //     // Update the state of the app.
              //     // ...
              //   },
              // ),
              // ListTile(
              //   title: Text("Rate Us"),
              //   onTap: () {
              //     // Update the state of the app.
              //     // ...
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.arrow_left_outlined),
                title: Text("LogOut"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Card(
                          child: Center(
                              child: Text(
                        "Welcome!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      )))),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: StreamBuilder(
                          stream: cf.FirebaseFirestore.instance
                              .collection("wallet")
                              // .where("date",
                              //     isEqualTo: new DateTime.utc(
                              //         DateTime.now().year,
                              //         DateTime.now().month,
                              //         DateTime.now().day))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          backgroundColor: Colors.blue,
                                          strokeWidth: 3)));
                            } else if (!snapshot.hasData) {
                              return Center(
                                  child: Text("No new amount for today"));
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  cf.DocumentSnapshot ds =
                                      snapshot.data.documents[index];
                                  MoneyCard moneyCard = new MoneyCard(
                                      note: ds["note"],
                                      amount: ds["amount"],
                                      cd: ds["cd"],
                                      date: ds["date"]);
                                  int current_amount = int.parse(ds["amount"]);
                                  if (ds["cd"] == "c") {
                                    amount = amount + current_amount;
                                    print(amount);
                                    return Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.add),
                                            title: Text(moneyCard.amount),
                                            subtitle: Text(moneyCard.note),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    amount = amount - current_amount;
                                    print(amount);
                                    return Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.remove),
                                            title: Text(moneyCard.amount),
                                            subtitle: Text(moneyCard.note),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                              );
                            }
                          })),
                )
              ],
            )));
  }
}
