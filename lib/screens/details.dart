import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Details extends StatefulWidget {
  final bool userIsLogned;
  final String name;
  final int price;
  final String comp;
  final double starts;
  final String image;
  final String docId;

  Details(
      {this.userIsLogned,
      this.name,
      this.price,
      this.comp,
      this.starts,
      this.image,
      this.docId});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String address;
  String name;
  String phone;
  String details = "";
  _getUserinformation() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot) {
      address = DocumentSnapshot.data()["address"].toString();
      name = DocumentSnapshot.data()["name"].toString();
      phone = DocumentSnapshot.data()["phone"].toString();
      print(address + name + phone);
    });
  }

  int num = 1;
  @override
  Widget build(BuildContext context) {
    widget.userIsLogned ? _getUserinformation() : null;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.yellow[800],
            title: Text(
              "تفاصيل الوجبة",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      SmoothStarRating(
                        rating: widget.starts,
                        isReadOnly: true,
                        color: Colors.yellow[800],
                        size: 25,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        borderColor: Colors.yellow[700],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.price.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            " ل.س",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 150,
                      width: 200,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.yellow[700],
                                        size: 50,
                                      ),
                                      onPressed: widget.userIsLogned
                                          ? () async {
                                              await FirebaseFirestore.instance
                                                  .collection('favorite')
                                                  .doc(widget.docId +
                                                      FirebaseAuth.instance
                                                          .currentUser.uid)
                                                  .set(({
                                                    "docId": widget.docId,
                                                    "name": widget.name,
                                                    "userId": FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        .uid,
                                                    "image": widget.image,
                                                    "price": widget.price,
                                                    "starts": widget.starts,
                                                    "comp": widget.comp
                                                  }));
                                              Fluttertoast.showToast(
                                                  msg: "تم الاضافة الى المفضلة",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          : () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "يجب عليك تسجيل الدخول أولا",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            })),
                              Text(
                                "اضافة الى المفضلة",
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart_outlined,
                                      color: Colors.yellow[700],
                                      size: 50,
                                    ),
                                    onPressed: widget.userIsLogned
                                        ? () async {
                                            await FirebaseFirestore.instance
                                                .collection('card')
                                                .doc(widget.docId +
                                                    FirebaseAuth.instance
                                                        .currentUser.uid)
                                                .set(({
                                                  "docId": widget.docId,
                                                  "name": widget.name,
                                                  "userId": FirebaseAuth
                                                      .instance.currentUser.uid,
                                                  "image": widget.image,
                                                  "price": widget.price * num,
                                                  "num": num,
                                                  "note": details,
                                                  "confirm": false,
                                                }));
                                            Fluttertoast.showToast(
                                                msg: "تم الاضافة الى السلة",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        : () {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "يجب عليك تسجيل الدخول أولا",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }),
                              ),
                              Text(
                                "اضافة الى السلة",
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Center(
                      child: Text(
                        "عدد الأطباق",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.yellow[700],
                                size: 35,
                              ),
                              onPressed: () {
                                setState(() {
                                  num++;
                                });
                              }),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border: Border.all(color: Colors.yellow[700])),
                          child: Center(
                            child: Text(
                              num.toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.yellow[700],
                                size: 35,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (num == 1) {
                                  } else
                                    num--;
                                });
                              }),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "مكونات الوجبة",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.yellow[700])),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.comp,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "التعديل على الوجبة والملاحظات",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.yellow[700])),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            details = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ),
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
