import 'package:custApp/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool userIsLogned = false;
  _chekUser() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userIsLogned = true;
      });
    } else {
      setState(() {
        userIsLogned = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _chekUser();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: Drawerr(
              userIsLogned: userIsLogned,
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.yellow[800],
            title: Text(
              "الصفحة الرئيسية",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart_outlined), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
