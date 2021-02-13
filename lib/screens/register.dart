import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custApp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // المتغيرات الخاصة بالمدخلات من اليوزر
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  TextEditingController _address = TextEditingController();
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
              // كود الصورة في الخلفية
              Image.asset(
                "assets/images/background.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "التسجيل ",
                        style: TextStyle(
                          color: Colors.white,
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
                            controller: _name,
                            decoration: InputDecoration(
                              hintText: 'الرجاء ادخال الاسم الخاص بك  ',
                              labelText: 'الاسم',
                              prefixIcon: Icon(Icons.person),
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
                            keyboardType: TextInputType.number,
                            controller: _phone,
                            decoration: InputDecoration(
                              hintText: 'الرجاء ادخال رقم الهاتف الخاص بك  ',
                              labelText: 'رقم الهاتف',
                              prefixIcon: Icon(Icons.phone),
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                            controller: _password2,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'الرجاء ادخال تاكيد كلمة المرور',
                              labelText: 'تاكيد كلمة المرور',
                              prefixIcon: Icon(Icons.vpn_key),
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
                            controller: _address,
                            decoration: InputDecoration(
                              hintText: 'الرجاء ادخال العنوان  الخاص بك  ',
                              labelText: 'العنوان',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 3),
                                borderRadius: BorderRadius.circular((25)),
                              ),
                            )),
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
                                width: MediaQuery.of(context).size.width / 2.5,
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
                                            builder: (BuildContext context) =>
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
                                width: MediaQuery.of(context).size.width / 2.5,
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
                                  "سجل ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  // تحقق اذا كل الخانات فارغة ام لا
                                  if (_email.text.isEmpty ||
                                      _password.text.isEmpty ||
                                      _name.text.isEmpty ||
                                      _password2.text.isEmpty ||
                                      _address.text.isEmpty ||
                                      _phone.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "يجب عليك ادخال جميع المطاليب  ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    // تحقق اذا كان تاكيد كلمة المرور متطابق ام لا
                                  } else if (_password.text !=
                                      _password2.text) {
                                    Fluttertoast.showToast(
                                        msg: "كلمة المرور غير متطابقة",
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
                                      // انشاء حساب بواسطة الايميل وكلمة المرور
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: _email.text,
                                                  password: _password.text);
                                      // ارسال تاكيد للايميل
                                      await userCredential.user
                                          .sendEmailVerification();
                                      // انشاء صف بجدول اليوزر
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userCredential.user.uid)
                                          .set(({
                                            'name': _name.text,
                                            'email': _email.text,
                                            'phone': _phone.text,
                                            'address': _address.text,
                                            'userId': userCredential.user.uid
                                          }));

                                      Fluttertoast.showToast(
                                          msg:
                                              "يرجى تاكيد حسابك , تحقق من علبة البريد الالكتروني",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Login()));

                                      setState(() {
                                        load = false;
                                      });
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
                                          .contains("weak-password")) {
                                        Fluttertoast.showToast(
                                            msg: "كلمة المرور ضعيفة",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else if (e
                                          .toString()
                                          .contains("email-already-in-use")) {
                                        Fluttertoast.showToast(
                                            msg: "هذا الايميل مستخدم",
                                            toastLength: Toast.LENGTH_SHORT,
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
                  ),
                ],
              ),
              // لاظهار اشارة التحميل على الشاشة اثناء التسجيل
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
