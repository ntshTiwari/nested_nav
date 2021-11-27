import 'package:flutter/material.dart';
import 'package:nested_nav/navigator_keys.dart';
import 'package:nested_nav/tab_navigator.dart';

void main() {
  runApp(MyApp());
}

/// Main ingredient to nested navigation is a second Navigator widget
/// When we start with a MaterialApp we introduce a Navigator which we use throughout the app
/// To introduce new navigation we need to introduce a new Navigator widget
/// When we call 'Navigator.method()' then the nearest Navigator widget (above this widget in widget tree) is used.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorKeys.navigatorKeyMain,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// can be used to add navigation based on bottomNavigation screen index
  GlobalKey<NavigatorState> _navigatorKey() {
    switch (_selectedIndex) {
      case 0:
        return NavigatorKeys.bottomNavigationBarFirstItem;
      case 1:
        return NavigatorKeys.bottomNavigationBarSecondItem;
      default:
        return NavigatorKeys.bottomNavigationBarThirdtItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Navigation example'),
      ),
      body: NestedScreen(
        /// If we dont supply key, then on change of index, body wont re-render
        // key: Key(_selectedIndex.toString()),
        navigatorKey: _navigatorKey(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
