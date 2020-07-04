import 'package:flutter/foundation.dart';
//import 'package:sqflite/sqlite_api.dart';

class Transaction {
  String id;
  String title;
  double value;
  String broker;
  DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.value,
    @required this.broker,
    @required this.date,
  });

  
}
