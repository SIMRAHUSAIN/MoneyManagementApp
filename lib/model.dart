import "dart:convert";

class MoneyCard {
  String note, cd, amount, date;

  MoneyCard({this.note, this.cd, this.amount, this.date});

  //factory returns the instance of class
  factory MoneyCard.fromJson(Map<String, dynamic> jsonData) {
    return MoneyCard(
        note: jsonData["note"],
        amount: jsonData["amount"],
        cd: jsonData["cd"],
        date: jsonData["date"]);
  }

  //declaring a map
  static Map<String, dynamic> toMap(MoneyCard task) => {
        "cd": task.cd,
        "amount": task.amount,
        "note": task.note,
        "date": task.date
      };

  //converting string type to json rep for data storage
  static String encodeTasks(List<MoneyCard> tasks) => json.encode(tasks
      .map<Map<String, dynamic>>((tasks) => MoneyCard.toMap(tasks))
      .toList());

  //converting jsonencoded string back to map
  static List<MoneyCard> decodeTasks(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<MoneyCard>((item) => MoneyCard.fromJson(item))
          .toList();
}
