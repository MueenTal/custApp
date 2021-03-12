import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custApp/screens/card.dart';
import 'package:custApp/screens/details.dart';
import 'package:custApp/screens/favorite.dart';
import 'package:custApp/screens/viewItemsType.dart';
import 'package:custApp/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // دالة التحقق من ان المستخدم مسجل دخول ام لا
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
                    icon: Icon(Icons.favorite),
                    onPressed: userIsLogned
                        ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => Favorite()));
                          }
                        : () {
                            Fluttertoast.showToast(
                                msg: "يجب عليك تسجيل الدخول أولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }),
                // ايقونة السلة الموجودة بالاعلى
                IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: userIsLogned
                        ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CardScreen()));
                          }
                        : () {
                            Fluttertoast.showToast(
                                msg: "يجب عليك تسجيل الدخول أولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          })
              ],
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Colors.white,
                        child: Center(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              collection("الأطباق الرئيسية", "main"),
                              collection("سناك", "snak"),
                              collection("حلويات", "hlweat"),
                              collection("مقبلات", "mokblat"),
                              collection("الأطباق الصحية", "shy")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 195,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('items')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return item(
                                document.data()['name'],
                                document.data()['image'],
                                document.data()['price'],
                                document.data()['comp'],
                                document.data()['starts'],
                                document.id);
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget collection(name, type) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.yellow[800]),
        child: FlatButton(
            child: Text(
              name,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ViewItems(
                        name: name,
                        type: type,
                        userIsLogined: userIsLogned,
                      )));
            }),
      ),
    );
  }

  Widget item(name, image, price, comp, rating, docId) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Details(
                  name: name,
                  image: image,
                  price: price,
                  comp: comp,
                  starts: rating,
                  userIsLogned: userIsLogned,
                  docId: docId,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 270,
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow[800],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  image,
                  // height: 200,
                  // width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "الاسم",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Center(
                            child: Text(
                              name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "السعر :",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          price.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                    SmoothStarRating(
                      rating: rating,
                      isReadOnly: true,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width / 20,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      allowHalfRating: true,
                      spacing: 2.0,
                      borderColor: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
