import 'package:flutter/material.dart';

class DepositsAcc {
  String accno;
  String bankName;
  String principal;
  String maturity;
  String rate;
  String term;
  String key;

  DepositsAcc({
    @required this.key,
    @required this.accno,
    @required this.principal,
    @required this.term,
    @required this.bankName,
    @required this.rate,
    this.maturity = "0",
  });

  DepositsAcc.fromJson(this.key, Map data) {
    accno = data['accno'];
    bankName = data['bankName'];
    principal = data['principal'].toString();
    maturity = data['maturity'].toString();
    rate = data['rate'].toString();
    term = data['term'].toString();
  }

  Map<String, dynamic> toJson() => {
    'accno': accno,
    'bankName': bankName,
    'principal': principal,
    'maturity': maturity,
    'rate': rate,
    'term': term,
    'key': key,
  };

}
