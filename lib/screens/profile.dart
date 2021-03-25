import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String address;
  String name;
  String phone;
  TextEditingController _password = TextEditingController();
  bool loading = false;

  String email;

  String details = "";
  _getUserinformation() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot) {
      setState(() {
        address = DocumentSnapshot.data()["address"].toString();
        name = DocumentSnapshot.data()["name"].toString();
        phone = DocumentSnapshot.data()["phone"].toString();
        email = DocumentSnapshot.data()["email"].toString();
      });

      print(address + name + phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getUserinformation();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.yellow[800],
            title: Text(
              "الصفحة الشخصية",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "الاسم",
                        style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: Text(
                      name == null ? "" : "   $name",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 16,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "الايميل",
                        style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: Text(
                      email == null ? "" : "   $email",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "رقم الهاتف",
                        style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 50,
                    child: Text(
                      phone == null ? "" : "   $phone",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "لعنوان",
                        style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 100,
                    child: Text(
                      address == null ? "" : "   $address",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "تغيير كلمة المرور",
                        style: TextStyle(fontSize: 20, color: Colors.blue[800]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]))),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "   كلمة المرور الجديدة",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
                loading
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox(
                        height: 50,
                      ),
                Center(
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width - 40,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_password.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "يجب ادخال كلمة المرور الجديدة",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            try {
                              User user =
                                  await FirebaseAuth.instance.currentUser;
                              await user.updatePassword(_password.text);
                              Fluttertoast.showToast(
                                  msg: "تم تغيير كلمة المرور بنجاح",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "عذرا , حدث خطا حاول مرة اخرى",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        elevation: 5.0,
                        color: Colors.yellow[800],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "تغيير كلمة المرور",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: MediaQuery.of(context).size.width / 25),
                        ),
                      )),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
