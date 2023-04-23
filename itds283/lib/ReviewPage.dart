import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AddReview.dart';
import 'homepage.dart';

class ReviewPage extends StatefulWidget {
  String? gameName;
  ReviewPage({this.gameName});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    print('this is for debuging: ${widget.gameName}');
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('error!'),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                title: Text('Review'),
                centerTitle: true,
                backgroundColor: Colors.blueGrey,
              ),
              body: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('${widget.gameName}').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['comment'],
                          style: TextStyle(
                            color: Colors.black
                          ),
                          ),
                        ),
                        //color: Color.fromARGB(255, 0, 0, 0),
                      );
                    }).toList(),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddReviewPage()),
                    );
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReviewPage(gameName: widget.gameName,)));
                },
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
