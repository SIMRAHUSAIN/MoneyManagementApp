import 'package:expenser/firebaseServices/services.dart';
import 'package:expenser/model.dart';
import 'package:flutter/material.dart';

class CreDialog extends StatefulWidget {
  @override
  _CreDialogState createState() => _CreDialogState();
}

class _CreDialogState extends State<CreDialog> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("CREDIT",
                style: TextStyle(
                    color: Colors.black,
                    //   fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Amount:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 30),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: TextField(
                      controller: _controller1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        labelText: "Enter Amount",
                        contentPadding: EdgeInsets.all(8),
                        // enabledBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide:
                        //         BorderSide(color: Colors.black, width: 0.5)),
                        // disabledBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide:
                        //         BorderSide(color: Colors.black, width: 0.5)),
                        // focusedBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide:
                        //         BorderSide(color: Colors.black, width: 0.5))),
                        //autofocus in notes textfield for saving data automatically
                      )),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Add Note(Optional)",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: TextField(
                  controller: _controller2,
                  maxLines: 1,
                  decoration: InputDecoration(
                      fillColor: Colors.black,
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      labelText: "Note",
                      contentPadding: EdgeInsets.all(8),
                      labelStyle: TextStyle(color: Colors.black))
                  // enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide:
                  //         BorderSide(color: Colors.black, width: 0.5)),
                  // disabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide:
                  //         BorderSide(color: Colors.black, width: 0.5)),
                  // focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide:
                  //         BorderSide(color: Colors.black, width: 0.5))),
                  ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  elevation: 1,
                  onPressed: () {
                    MoneyCard moneyCard = new MoneyCard(
                        amount: _controller1.text.trim(),
                        cd: "c",
                        date: "",
                        // date: DateTime.now(),
                        note: _controller2.text.trim());
                    DatabaseServices().newMoneyAdded(moneyCard);
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Container(
                      height: 30,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
