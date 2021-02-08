import 'package:custApp/screens/homeScreen.dart';
import 'package:custApp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Drawerr extends StatefulWidget {
  final bool userIsLogned;
  Drawerr({this.userIsLogned});
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.yellow[600],
              Colors.yellow[600],
            ])),
            child: Container(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    child: Image.asset(
                      "assets/images/chef.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    'بين ايديك',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                )
              ],
            ))),
        CustomListTitle(
            widget.userIsLogned ? Icons.logout : Icons.login,
            widget.userIsLogned ? "تسجيل الخروج" : "تسجيل الدخول",
            widget.userIsLogned
                ? () {
                    FirebaseAuth.instance.signOut();
                    Fluttertoast.showToast(
                        msg: "تم تسجيل الخروج بنجاح",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
                  }
                : () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Login()));
                  }),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CustomListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTitle(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: InkWell(
          splashColor: Colors.yellow[600],
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(
                    icon,
                    size: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ]),
                Icon(
                  Icons.arrow_right,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
