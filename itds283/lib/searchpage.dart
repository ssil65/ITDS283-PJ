import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'games.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Games _listOfGames;

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  Future<Games> getApiData() async {
    var url = Uri.parse(
        "https://api.rawg.io/api/games?key=432c7547cdb24be9a29aaa9812511ffd&dates=2019-01-01,2020-01-01");
    //2022-04-01,2023-04-01
    var response = await http.get(url);

    _listOfGames = gamesFromJson(response.body);
    return _listOfGames;
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController searchValue = TextEditingController();
    return Scaffold(
      body: FutureBuilder(
          future: getApiData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            var result = snapshot.data;

            //print(result.results.length); //for debuging
            if (snapshot.connectionState == ConnectionState.done) {
              var display_list = result.results;
              print(display_list.runtimeType);
              void updateList(String value) {
                setState(() {
                  display_list = display_list.where((el) => el.name.toLowerCase().contains(value.toLowerCase()));

                  //.toLowerCase().contains(value.toLowerCase());
                });
              }

              //print(result.results.length); //for debuging
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                ),
                body: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search for a Games',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) => updateList(value),
                        controller: searchValue,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'eg: Control',
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.purple.shade900,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: display_list.length,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: EdgeInsets.all(8),
                            title: Text(
                              display_list[index].name!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: Image.network(
                                '${display_list[index].backgroundImage}'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
