import 'package:money_monitor/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:money_monitor/scoped_models/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:money_monitor/scoped_models/main.dart';


class KeyDatesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KeyDatesState();
  }
}

class _KeyDatesState extends State<KeyDatesPage> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  String _nameFormData;
  bool darkThemeVal;

  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    _nameFormData = "";
    darkThemeVal = deviceTheme == "light" ? false : true;
  }


  final body1Style = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 26.0,
    color: Colors.black,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deviceTheme == "light"
          ? Colors.green[100]
          : Theme
          .of(context)
          .primaryColorLight,
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        color: deviceTheme == "light" ? Colors.white : Colors.grey[900],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  MdiIcons.cashRegister,
                  size: 30,
                  color: _selectedIndex == 0
                      ? Theme.of(context).accentColor
                      : Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.settings,
                  size: 30,
                  color: _selectedIndex == 1
                      ? Theme.of(context).accentColor
                      : Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody(){
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget widget, MainModel model) {
        return GestureDetector(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: deviceTheme == "light"
                    ? Theme.of(context).accentColor
                    : Colors.grey[900],
                pinned: false,
                floating: false,
                expandedHeight: 180.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Text(" Key Payment Dates ",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2.5,
                          ),
                          color: Colors.cyan[400],
                        ),
                        Card(
                          child: Text("Total Due this month \$3023.00",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2.5,
                          ),
                          color: Colors.blue
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 2.0),
                      color: deviceTheme == "light"
                          ? Colors.white
                          : Colors.grey[800],
                      child: ListTile(
                        title: Text("Upcoming Payments", textAlign: TextAlign.center, textScaleFactor: 1.5,),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        KeyDateCard(keyDate: "Mon 1 Jul",
                          cardColour: Colors.deepOrange,
                          keyDateText: "House Loan Installment",
                          amount: 1023.00,
                        ),
                        KeyDateCard(keyDate: "Mon 2 Jul",
                          cardColour: Colors.deepOrange,
                          keyDateText: "Mobile Bill",
                          amount: 78.00,
                        ),
                        KeyDateCard(keyDate: "Mon 3 Jul",
                          cardColour: Colors.deepOrange,
                          keyDateText: "Internet/Cable Bill",
                          amount: 102.00,
                        ),
                        KeyDateCard(keyDate: "Mon 4 Jul",
                          cardColour: Colors.deepOrange,
                          keyDateText: "Netflix Subscription",
                          amount: 15.00,
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}

class KeyDateCard extends StatelessWidget {

  String keyDate;
  Color cardColour;
  String keyDateText;
  double amount;

  KeyDateCard({@required this.keyDate, this.cardColour,this.keyDateText, this.amount });

  var formatter = new DateFormat('E dd MMM');
  var now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: RaisedButton(
                  child: Text(keyDate, textScaleFactor: 1.3,),
                    onPressed: null,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                    disabledColor: Colors.deepPurple,
                    disabledTextColor: Colors.white,
                ),
             ),
           ),
            Expanded(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(keyDateText, textScaleFactor: 1.3,),
          ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: RaisedButton(
                  child: Text("\$" + amount.toStringAsFixed(2),
                    textScaleFactor: 1.2,
                  ),
                  onPressed: null,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  disabledTextColor: Colors.white,
                  disabledColor: Colors.blue[600],
              ),
            ),
          ),
        ],
      ),
      color: Colors.teal[100],
    );
  }
}
