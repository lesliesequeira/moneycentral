import 'package:flutter/material.dart';

class SavingsAcc {
  String accno;
  String bankName;
  String deposits;
  String withdrawls;
  String balance;
  String key;


  SavingsAcc({
    @required this.accno,
    @required this.bankName,
    @required this.key,
    this.deposits = "0",
    this.balance = "0",
    this.withdrawls = "0",
  });

  SavingsAcc.fromJson(this.key, Map data) {
    accno = data['accno'];
    bankName = data['bankName'];
    deposits = data['deposits'].toString();
    withdrawls = data['withdrawls'].toString();
    balance = data['balance'].toString();
  }

  Map<String, dynamic> toJson() => {
    'accno': accno,
    'bankName': bankName,
    'deposits': deposits,
    'withdrawls': withdrawls,
    'balance': balance,
    'key:': key,
  };

}
