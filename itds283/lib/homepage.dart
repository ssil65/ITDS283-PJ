import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itds283/gamesInfo.dart';
import 'package:itds283/searchpage.dart';
import 'contact_page.dart';
import 'games.dart';
import 'signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Games _listOfGames;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  Future<Games> getApiData() async {
    var url = Uri.parse(
        "https://api.rawg.io/api/games?key=432c7547cdb24be9a29aaa9812511ffd&dates=2019-01-01,2020-01-01");
    var response = await http.get(url);

    _listOfGames = gamesFromJson(response.body);
    return _listOfGames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getApiData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;

          //print(result.results.length);

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text('Home', style: TextStyle(fontSize: 25)),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.contact_support),
                  tooltip: 'Contact',
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactPage()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  tooltip: 'Sign Out',
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignInPage()));
                  },
                ),
              ],
              backgroundColor: Colors.blueGrey,
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: result.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          color: Colors.grey,
                          elevation: 15,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Image.network(
                                    '${result.results[index].backgroundImage}'),
                                //width: 150,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          result.results[index].name +
                                              ' ${result.results[index].id}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    gameInfo()),
                                          );
                                          print(result.results[index].name);
                                          print(result
                                              .results[index].backgroundImage);
                                          print(result.results[index].id);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      gameInfo(
                                                        gameName: result
                                                            .results[index]
                                                            .name,
                                                        gameImage: result
                                                            .results[index]
                                                            .backgroundImage,
                                                        id: result
                                                            .results[index].id,
                                                      )));
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    ));
  }
}
