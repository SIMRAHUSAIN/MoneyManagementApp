import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenser/model.dart';
import 'package:intl/intl.dart';

class DatabaseServices {
  final CollectionReference moneyCollection =
      FirebaseFirestore.instance.collection("wallet");

  Future newMoneyAdded(MoneyCard newMoney) async {
    print("added");
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    var now = new DateTime.now();
    var format = new DateFormat('yyyyMMddHHmmss');
    String dt = formatter.format(now);
    String id = format.format(now);
    return await moneyCollection.doc(id).set({
      "amount": newMoney.amount,
      "cd": newMoney.cd,
      "date": dt,
      "note": newMoney.note
    });
  }
}


//string matching  