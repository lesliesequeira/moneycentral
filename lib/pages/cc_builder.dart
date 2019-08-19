import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_monitor/models/ccExpense.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:money_monitor/scoped_models/main.dart';
import 'package:money_monitor/widgets/cc/ccexpense_list.dart';
import 'package:money_monitor/models/category.dart';

class CCExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        if (model.syncStatus) {
          return CCExpenseList();
        }
        return FutureBuilder(
          future: FirebaseDatabase.instance
              .reference()
              .child('users/${model.authenticatedUser.uid}')
              .once(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            List<CCExpense> ccexpenses = [];
            List<Category> categories = [];
            String theme;
            String currency;
            String monthlyTarget;
            String yearlyTarget;

            Map<dynamic, dynamic> categoryMap;
            Map<dynamic, dynamic> ccExpenseMap = snapshot.data.value;
            if (ccExpenseMap != null) {
              ccExpenseMap.forEach((key, value) {
                if (key == "ccExpenses") {
                  Map<dynamic, dynamic> expenseT = value;
                  expenseT.forEach((key, value) {
                    ccexpenses.add(CCExpense.fromJson(key, value));
                  });
                }
                if (key == "preferences") {
                  Map<dynamic, dynamic> pref = value;
                  pref.forEach((key, value) {
                    if (key == "theme") {
                      theme = value;
                    }

                    if (key == "currency") {
                      currency = value;
                    }

                    if (key == "userCategories") {
                      categoryMap = value;
                    }
                    if (key == "monthlyTarget") {
                      monthlyTarget = value;
                    }
                    if (key == "yearlyTarget") {
                      yearlyTarget = value;
                    }

                  });
                }
              });

              if (categoryMap != null) {
                categoryMap.forEach((key, value) {
                  categories.add(Category.fromJson(key, value));
                });
              }

              model.setPreferences(theme, currency, categories, monthlyTarget, yearlyTarget);
              if (ccexpenses.length > 0) {
                model.setCCExpenses(ccexpenses);
              }
              model.toggleSynced();
            } else {
              model.gotNoData();
            }
            return CCExpenseList();
          },
        );
      },
    );
  }
}
