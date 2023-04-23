import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ReviewPage.dart';
import 'homepage.dart';

class AddReviewPage extends StatefulWidget {
  String? gameName;
  AddReviewPage({this.gameName});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController commentValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('error!!'),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            CollectionReference _commentCollection =
                FirebaseFirestore.instance.collection('${widget.gameName}');
            print('this is for debuging: ${widget.gameName}');
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewPage()),
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReviewPage(
                              gameName: widget.gameName,
                            )));
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                ],
                title: Text('Add Your Comment'),
                centerTitle: true,
                backgroundColor: Colors.blueGrey,
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What do you think?',style: TextStyle(color: Colors.white),),
                    Card(
                      child: TextField(
                        controller: commentValue,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 59, 57, 88),
                            foregroundColor:
                                Color.fromARGB(255, 255, 255, 255)),
                        child: Text('ยืนยัน'),
                        onPressed: () async {
                          print('${commentValue.text}');
                          await _commentCollection
                              .add({"comment": commentValue.text});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewPage()),
                          );
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReviewPage(
                                    gameName: widget.gameName,
                                  )));
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text("loading..."),
              ),
            );
          }
        });
  }
}


/*
Form(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What do you think?'),
                        TextField(
                          controller: commentValue,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text('ยืนยัน'),
                            onPressed: () async {
                              print('${commentValue.text}');
                              await _commentCollection
                                  .add({"comment": commentValue.text});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),

 */
