import 'package:expenser/model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
  }

  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EXPENSER",
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction History",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tap to edit/delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    //   color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: StreamBuilder(
                        stream: cf.FirebaseFirestore.instance
                            .collection("wallet")
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
                            return Center(child: Text("No note present"));
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
                        })))
          ],
        ),
      ),
    );
  }
}
