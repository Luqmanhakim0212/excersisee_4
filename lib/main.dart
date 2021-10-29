import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Scrollable',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key?key}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/MOCK_DATA.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'My Contact',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, id) {
                  return Card(
                    // margin: const EdgeInsets.all(10),
                    child: Row(
                      // leading: Text(_items[id]["last_seen_time"]), //Image.network("${_items[id]["avatar"]}"),
                      // title: Text(_items[id]["first_name"]),
                      // subtitle: Text(_items[id]["last_name"]),
                      //avatar: Image.network("${_items[id]["avatar"]}"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                              // child: Image.network("${_items[id]["avatar"]}"),
                            backgroundImage: _items[id].containsKey("avatar") ? NetworkImage(_items[id]["avatar"]) : NetworkImage("https://www.vhv.rs/dpng/d/526-5268314_empty-avatar-png-user-icon-png-transparent-png.png"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(_items[id]["first_name"],style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(_items[id]["last_name"],style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Text(_items[id]["username"]),
                            Text(_items[id].containsKey("status") ? _items[id]["status"] : " ", style: TextStyle(color: Colors.grey[500]),),

                          ],
                        ),
                       Spacer(),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           children: [
                             Text(_items[id]["last_seen_time"]),
                             CircleAvatar(
                                 child: Text(
                                     _items[id].containsKey("messages") ? _items[id]["messages"].toString() : " "
                                 )
                             ),
                           ],
                         ),
                       ),
                      ],
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
