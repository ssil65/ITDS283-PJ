import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:itds283/ReviewPage.dart';
import 'package:itds283/homepage.dart';
import 'AddReview.dart';
import 'package:http/http.dart' as http;
import 'gameinfo_model.dart';

class gameInfo extends StatefulWidget {
  String? gameName;
  String? gameImage;
  int? id;

  gameInfo({this.gameName, this.gameImage, this.id});

  @override
  State<gameInfo> createState() => _gameInfoState();
}

class _gameInfoState extends State<gameInfo> {
  late Games _gameInfo;

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  Future<Games> getApiData() async {
    var url = Uri.parse(
        "https://api.rawg.io/api/games/${widget.id}?key=432c7547cdb24be9a29aaa9812511ffd");
    var response = await http.get(url);

    _gameInfo = gamesFromJson(response.body);
    return _gameInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getApiData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            var des = result.description;
            var newDes = des
                .replaceAll('<p>', '')
                .replaceAll('</p>', '')
                .replaceAll('<h3>', '')
                .replaceAll('</h3>', '');
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
                title: Text('Game Info'),
                centerTitle: true,
                backgroundColor: Colors.blueGrey,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Image.network('${widget.gameImage}'),
                      
                      width: 500,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.gameName}',
                      style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      color: Color.fromARGB(255, 21, 25, 58),
                      child: Text(
                        newDes,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: const Color.fromARGB(255, 59, 57, 88),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255)),
                    child: const Text(
                      'comment',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                      onPressed: () {
                        print(
                            'this is what game info send to review and adding review page: ${widget.gameName}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReviewPage()),
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReviewPage(
                                  gameName: widget.gameName,
                                )));
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
