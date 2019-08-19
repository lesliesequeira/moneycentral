import 'package:money_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:money_monitor/scoped_models/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money_monitor/pages/module_main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class BankAcsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BankAcsPageState();
  }
}

class _BankAcsPageState extends State<BankAcsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    "monthlyTarget": null,
    "yearlyTarget": null,
  };
 bool darkThemeVal;

  @override
  void initState() {
    super.initState();
    darkThemeVal = deviceTheme == "light" ? false : true;
  }

  void _onHomePressed() {
    print("Home button clicked");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ModulesPage(),
      ),
    );
  }

  _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: deviceTheme == "light"
            ? Theme.of(context).accentColor
            : Colors.grey[900],
      ),
      child: MaterialButton(
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return "";
          }
          _formKey.currentState.save();
/*
          changeAmount(
            montlyTarget: _formData["monthlyTarget"],
            yearlyTarget: _formData['yearlyTarget'],
            context: context,
          );
*/
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildCancelButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: deviceTheme == "light"
            ? Theme.of(context).accentColor
            : Colors.grey[900],
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTargetField(String label, String targetName) {
    return Card(
      clipBehavior: Clip.none,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        validator: (String value) {
          if (value.length <= 0) {
            return "Please enter a Target ";
          }
        },
        onSaved: (String value) => _formData[targetName] = value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 2.0,
            vertical: 2.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintText: label,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          hasFloatingPlaceholder: true,
          prefix: Text("  "),
          filled: true,
          fillColor: deviceTheme == "light" ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }

  static const PrimaryColor =  Color(0xFFC8E6C9);

  Card topArea() => Card(
    margin: EdgeInsets.all(10.0),
    elevation: 2.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0))),
    child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
        padding: EdgeInsets.all(5.0),
        // color: Color(0xFF015FFF),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Text("Bank Accounts",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ],
        )),
  );

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        String monthlyTarget = "3000.00"/*model.userMonthlyTarget*/;
        String yearlyTarget = "36,000.00" /*model.userYearlyTarget;*/;

        return Scaffold(
          body: GestureDetector(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: PrimaryColor,
                  pinned: false,
                  floating: false,
                  expandedHeight: 100.0,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FlexibleSpaceBar(
                      background: topArea()
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 7),
                            child: Text(
                              "Savings Accounts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        color: PrimaryColor
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MessageCard(mainText: "Deposits",
                            currency: "\$",
                            amount: monthlyTarget,
                          ),
                          MessageCard(mainText: "Withdrawls",
                            currency: "\$",
                            amount: yearlyTarget,
                          ),
                          MessageCard(mainText: "Balance",
                            currency: "\$",
                            amount: yearlyTarget,
                          ),

                        ],
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 7.0),
                            child: Text(
                              "Fixed Deposits",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        color: PrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print("Floating Button clicked");
            },
            backgroundColor: Theme.of(context).primaryColorLight,
            elevation: 5.0,
            icon: const Icon(Icons.add),
            label: const Text('Add Savings/Deposit'),
          )
          ,
        );
      },
    );
  }
}

class MessageCard extends StatelessWidget {

  MessageCard({@required this.mainText, this.currency, this.amount });
  String mainText;
  String currency;
  String amount;

  static const PrimaryColor =  Color(0xFF4CAF50);
  static const PrimaryAssentColor =  Color(0xFF8BC34A);
  static const PrimaryDarkColor =  Color(0xFF388E3C);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0,
          child: SizedBox(
            height: 80.0,
            width: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        mainText,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              currency,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 20.0),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              amount,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}

