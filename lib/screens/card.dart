import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardScreen> {
  int sum = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.yellow[800],
            title: Text(
              "السلة",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('card')
                      .where('userId',
                          isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .where('confirm', isEqualTo: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return item(
                            document.data()['name'],
                            document.data()['image'],
                            document.data()['price'],
                            document.data()['num'],
                            document.id);
                      }).toList(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: (MediaQuery.of(context).size.height / 2) - 150,
                  //    color: Colors.grey[200],
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "السعر الكلي : ",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            sum.toString() + " ل.س",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget item(name, image, price, number, id) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.yellow[800],
            ),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 15,
                      ),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "الكمية",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "السعر",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Center(
                          child: Text(
                            price.toString() + " ل.س",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ])
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
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.delete_forever_outlined),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('card')
                      .doc(id)
                      .delete();
                  Fluttertoast.showToast(
                      msg: "تم حذف الوجبة من السلة بنجاح",
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
