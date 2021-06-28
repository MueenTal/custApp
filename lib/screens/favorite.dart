import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custApp/screens/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.yellow[600],
            title: Text(
              "المفضلة",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('favorite')
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return item(
                      document.data()['name'],
                      document.data()['image'],
                      document.data()['price'],
                      document.data()['comp'],
                      document.data()['starts'],
                      document.data()['docId'],
                      document.id);
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget item(name, image, price, comp, rating, docId, id) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Details(
                      name: name,
                      image: image,
                      price: price,
                      comp: comp,
                      starts: rating,
                      docId: docId,
                      userIsLogned: true,
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.yellow[600],
              ),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 6,
                        child: Center(
                          child: Text(
                            name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 140,
                      width: 140 * 1.5,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.delete_forever_outlined),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('favorite')
                      .doc(id)
                      .delete();
                  Fluttertoast.showToast(
                      msg: "تم حذف الوجبة من المفضلة بنجاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                })
          ],
        )
      ],
    );
  }
}
