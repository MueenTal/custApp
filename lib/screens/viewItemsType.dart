import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custApp/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ViewItems extends StatefulWidget {
  final String name;
  final String type;
  final bool userIsLogined;

  ViewItems({this.name, this.type, this.userIsLogined});
  @override
  _ViewItemsState createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
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
              widget.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height - 185,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('items')
                  .where('tyep', isEqualTo: widget.type.toString())
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
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
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
        ),
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
                  userIsLogned: widget.userIsLogined,
                  docId: docId,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 270,
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow[600],
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
