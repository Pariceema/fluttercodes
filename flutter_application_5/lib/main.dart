//API Calling
/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("API call"),
            ElevatedButton(
                onPressed: () {
                  print("clicked");
                  ApiCall();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

  void ApiCall() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'users');
    var response = await http.get(url);
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
  }
}*/

//On button click fetchdata
/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mydata = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("API Call"),
            ElevatedButton(
                onPressed: () {
                  print("Clicked");
                  ApiCall();
                },
                child: const Text("Submit")),
            Text(mydata),
          ],
        ),
      ),
    );
  }

  void ApiCall() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'users');
// https('hostname','(page_link)table')
    var response = await http.get(url);
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    setState(() {
      mydata = response.body;
    });
  }
}*/

//Fetch data on screen in table form
/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // for making HTTP requests
import 'dart:convert'; // library for JSON decoding

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Root widget of the application
      home: Scaffold(
        //basic layout structure
        appBar: AppBar(
          // Widget for the app bar
          title: const Text('API Demo'),
        ),
        body: Center(
          // Center its child widget vertically and horizontally
          child: FutureBuilder<http.Response>(
            // Widget to build UI based on a Future
            future:
                fetchData(), // Future that represents the result of the API call
            builder: (context, snapshot) {
              // Builder function to build the UI based on the state ofthe Future
              if (snapshot.hasError) {
                // Check if there's an error in the Future
                return Text(
                    'Error: ${snapshot.error}'); // Display error message if there's an error
              }
              if (snapshot.connectionState == ConnectionState.done) {
                // Check if the Future hascompleted
                var data = json
                    .decode(snapshot.data!.body); // Decode the JSON response
                return DataTable(
                  // Widget to display data in tabular format
                  columns: const [
                    // Define the columns of the DataTable
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Body')),
                  ],
                  rows: (data as List<dynamic>).map<DataRow>((item) {
                    // Map each item in thedata list to a DataRow
                    return DataRow(
                      // Widget to represent a row in the DataTable
                      cells: <DataCell>[
                        // Define the cells of the DataRow
                        DataCell(Text(item['userId'].toString())),
                        DataCell(Text(item['id'].toString())),
                        DataCell(Text(item['title'] ??
                            '')), // Display the title in a cell, handle null value
                        DataCell(Text(item['body'] ?? '')),
                      ],
                    );
                  }).toList(), // Convert the mapped rows to a list
                );
              }
              return CircularProgressIndicator(); // Display a loading indicator
            },
          ),
        ),
      ),
    );
  }

  Future<http.Response> fetchData() async {
    // Function to make the API call
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts'); // Define the URL for theAPI endpoint
    return await http
        .get(url); // Perform a GET request to fetch data from the API
  }
}*/

//Listview with API

/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Demo'),
        ),
        body: Center(
          child: FutureBuilder<http.Response>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var data = json.decode(snapshot.data!.body);
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.article), // Leading icon
                      title: Text(data[index]['title'] ?? ''),
                      subtitle: Text(data[index]['body'] ?? ''),
                      trailing: Icon(Icons.arrow_forward), // Trailing icon
// You can add more content to the list tile as needed
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<http.Response> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    return await http.get(url);
  }
}*/

//Animation of bigger fonts

/*import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 20.0, end: 50.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void increaseFontSize() {
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Center(child: Text('Flutter Animation')),
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Hello! Welcome.This is a basic demonstration of animation in Flutter.',
              style: TextStyle(fontSize: animation.value),
            )),
        ElevatedButton(
          onPressed: () => {increaseFontSize()},
          child: Text('Bigger Font'),
        )
      ]),
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}*/

//State management
//Implementing State management
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

/*void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: MyApp(),
    ),
  );
}

class MyModel with ChangeNotifier {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: Consumer<MyModel>(builder: (context, myModel, child) {
          return Text('Hey!');
        }),
      ),
    );
  }
}*/

//Tabbar & TabbarView

/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tabbar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.android),
                text: "Tab 1",
              ),
              Tab(icon: Icon(Icons.phone_iphone), text: "Tab 2"),
            ],
          ),
          title: Text('TabBar & TabBarView'),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Page 1")),
            Center(child: Text("Page 2")),
          ],
        ),
      ),
    );
  }
}*/

//Table

/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Table'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FractionColumnWidth(.4),
                  1: FractionColumnWidth(.2),
                  2: FractionColumnWidth(.4)
                },
                children: [
                  TableRow(children: [
                    Column(children: [
                      Icon(
                        Icons.account_box,
                        size: iconSize,
                      ),
                      Text('My Account')
                    ]),
                    Column(children: [
                      Icon(
                        Icons.settings,
                        size: iconSize,
                      ),
                      Text('Settings')
                    ]),
                    Column(children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: iconSize,
                      ),
                      Text('Ideas')
                    ]),
                  ]),
                  TableRow(children: [
                    Icon(
                      Icons.cake,
                      size: iconSize,
                    ),
                    Icon(
                      Icons.voice_chat,
                      size: iconSize,
                    ),
                    Icon(
                      Icons.add_location,
                      size: iconSize,
                    ),
                  ]),
                ],
              ),
            ),
          ]))),
    );
  }
}*/

//Tooltip

/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Tooltip Example"),
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Tooltip(
                  waitDuration: Duration(seconds: 1),
                  showDuration: Duration(seconds: 2),
                  padding: EdgeInsets.all(5),
                  height: 35,
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  message: 'My Account',
                  child: TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.account_box,
                      size: 100,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Tooltip(
                  message: 'My Account',
                  child: TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.account_box,
                      size: 100,
                    ),
                  )),
            )
          ]),
    );
  }
}*/

//Provider

/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count: ${counter.count}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                counter.increment();
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),

            /// Extracted as a separate widget for performance optimization.
            /// As a separate widget, it will rebuild independently from [MyHomePage].
            ///
            /// This is totally optional (and rarely needed).
            /// Similarly, we could also use [Consumer] or [Selector].
            Count(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      '${context.watch<Counter>().count}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}*/

//color picker
/*import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color currentColor = Colors.green;
  List<Color> currentColors = [Colors.yellow, Colors.red];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Color Picker'),
            backgroundColor: currentColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 1000,
              child: Column(
                children: [
                  Text("Block Picker"),
                  Expanded(
                    child: BlockPicker(
                        pickerColor: currentColor, onColorChanged: changeColor),
                  ),
                  SizedBox(height: 10),
                  Text("Material Picker"),
                  Expanded(
                    child: MaterialPicker(
                        pickerColor: currentColor, onColorChanged: changeColor),
                  ),
                  SizedBox(height: 10),
                  Text("MaterialChoiceBlockPicker"),
                  Expanded(
                    child: MultipleChoiceBlockPicker(
                      pickerColors: currentColors,
                      onColorsChanged: changeColors,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}*/

//Bloc

/*import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_5/app.dart';
import 'package:flutter_application_5/counter_observer.dart';

void main() {
  Bloc.observer = const CounterObserver();
  runApp(const CounterApp());
}*/




