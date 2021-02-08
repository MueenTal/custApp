import 'package:custApp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
            child: Scaffold(
                body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.yellow[600], Colors.yellow[800]])),
              ),
              ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 5,
                            left: MediaQuery.of(context).size.width / 8,
                            right: MediaQuery.of(context).size.width / 8,
                            bottom: MediaQuery.of(context).size.height / 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(38),
                              bottomRight: Radius.circular(38)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              "التسجيل ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    hintText: 'الرجاء ادخال الايميل الخاص بك',
                                    labelText: 'الايميل',
                                    prefixIcon: Icon(Icons.email),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightBlue, width: 3),
                                      borderRadius: BorderRadius.circular((25)),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                  controller: _password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'الرجاء ادخال كلمة المرور',
                                    labelText: 'كلمة المرور',
                                    prefixIcon: Icon(Icons.vpn_key),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightBlue, width: 3),
                                      borderRadius: BorderRadius.circular((25)),
                                    ),
                                  )),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8, bottom: 8),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.blue[300],
                                              Colors.blue[300],
                                            ])),
                                    child: FlatButton(
                                      child: Text(
                                        " تسجيل الدخول  ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Login()));
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 8, bottom: 8),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.blue[100],
                                              Colors.blue[100],
                                            ])),
                                    child: FlatButton(
                                      child: Text(
                                        " تسجيل  ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.red,
                                            Colors.red,
                                          ])),
                                  child: FlatButton(
                                      splashColor: Colors.blueAccent,
                                      child: Text(
                                        "سجل ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_email.text.isEmpty ||
                                            _password.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "يجب عليك ادخال كلمة المرور والايميل",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          try {
                                            UserCredential userCredential =
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                        email: _email.text,
                                                        password:
                                                            _password.text);
                                            userCredential.user
                                                .sendEmailVerification();

                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Login()));

                                            Fluttertoast.showToast(
                                                msg:
                                                    "يرجى تاكيد حسابك , تحقق من علبة البريد الالكتروني",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } catch (e) {
                                            print(e);

                                            if (e
                                                .toString()
                                                .contains("invalid-email")) {
                                              Fluttertoast.showToast(
                                                  msg: "خطا في ادخال الايميل",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (e
                                                .toString()
                                                .contains("weak-password")) {
                                              Fluttertoast.showToast(
                                                  msg: "كلمة المرور ضعيفة",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (e.toString().contains(
                                                "email-already-in-use")) {
                                              Fluttertoast.showToast(
                                                  msg: "هذا الايميل مستخدم",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              print("");
                                            }
                                          }
                                        }
                                      }),
                                ))
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ))));
  }
}
