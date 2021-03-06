import 'package:custApp/screens/homeScreen.dart';
import 'package:custApp/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // المتغيرات الخاصة بالايميل والباسوورد
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool load = false;

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
              Image.asset(
                "assets/images/background.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                child: ListView(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "تسجيل الدخول",
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
                          SizedBox(
                            height: 50,
                          ),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8, bottom: 8),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.blue[100],
                                              Colors.blue[100],
                                            ])),
                                    child: FlatButton(
                                      child: Text(
                                        " تسجيل الدخول  ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 8, bottom: 8),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.blue[300],
                                              Colors.blue[300],
                                            ])),
                                    child: FlatButton(
                                      child: Text(
                                        " تسجيل  ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Register()));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
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
                                      "سجل الدخول",
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
                                          setState(() {
                                            load = true;
                                          });
                                          // تسجيل الدخول بواسطة الايميل وكلمة المرور
                                          UserCredential userCredential =
                                              await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: _email.text,
                                                      password: _password.text);
                                          // التحقق اذا كان كان الحساب تم تاكيده بالايميل
                                          if (!userCredential
                                              .user.emailVerified) {
                                            Fluttertoast.showToast(
                                                msg: "عذرا يجب تاكيد ايميلك ",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            FirebaseAuth.instance.signOut();
                                            setState(() {
                                              load = false;
                                            });
                                          } else {
                                            // الانتقال اللى الصفحة الاخرى في حال تم تسجيل الدخول بنجاح
                                            Fluttertoast.showToast(
                                                msg: "تم تسجيل الدخول بنجاح",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            HomeScreen()));
                                            setState(() {
                                              load = false;
                                            });
                                          }
                                        } catch (e) {
                                          setState(() {
                                            load = false;
                                          });
                                          print(e);
// في حال اكتشاف اخطاء من الفير بيز سيتم طباعة الخطا للمستخدم حسب الوارد من الباك اند

                                          if (e
                                              .toString()
                                              .contains("invalid-email")) {
                                            Fluttertoast.showToast(
                                                msg: "خطا في ادخال الايميل",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else if (e
                                              .toString()
                                              .contains("user-not-found")) {
                                            Fluttertoast.showToast(
                                                msg: "المستخدم غير موجود",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else if (e
                                              .toString()
                                              .contains("wrong-password")) {
                                            Fluttertoast.showToast(
                                                msg: "كلمة المرور خطا",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else if (e
                                              .toString()
                                              .contains("too-many-requests")) {
                                            Fluttertoast.showToast(
                                                msg: "وحدوا الله شوي",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            print("");
                                          }
                                        }
                                      }
                                    }),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              load
                  ? Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container()
            ],
          ),
        ))));
  }
}
