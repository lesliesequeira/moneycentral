import 'package:flutter/material.dart';

class CCExpense {
  String title;
  String category;
  String amount;
  String creditCardName;
  String createdAt;
  String note;
  String key;

  CCExpense({
    @required this.title,
    @required this.amount,
    @required this.key,
    @required this.createdAt,
    @required this.creditCardName,
    this.category = "",
    this.note = "",
  });

  CCExpense.fromJson(this.key, Map data) {
    title = data['title'];
    category = data['category'];
    amount = data['amount'].toString();
    createdAt = data['createdAt'].toString();
    note = data['note'];
    creditCardName = data['creditCardName'];
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'category': category,
    'amount': amount,
    'createdAt': createdAt,
    'note': note,
    'key': key,
    'creditCardName': creditCardName,
  };

}
