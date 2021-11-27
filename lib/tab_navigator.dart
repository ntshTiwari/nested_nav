import 'package:flutter/material.dart';
import 'package:nested_nav/navigator_keys.dart';

class NestedScreenRoutes {
  static const String root = '/';
  // static const String detail1 = '/detail1';
  // static const String detail2 = '/detail2';
}

class NestedScreen extends StatelessWidget {
  NestedScreen({this.navigatorKey, Key key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;

  /// Will be used to navigate

  void _push(BuildContext context, String name) {
    // Navigator.of(navigatorKey.currentContext).push(
    //
    BuildContext _desiredContext;

    if (name == 'Page 1') {
      _desiredContext = navigatorKey.currentContext;
    } else {
      _desiredContext = NavigatorKeys.navigatorKeyMain.currentContext;
    }
    Navigator.of(_desiredContext).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.grey[700],
          appBar: AppBar(
            title: Text('Nested screen'),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.keyboard_arrow_left_outlined),
            ),
            backgroundColor: Colors.black,
            elevation: 15,
          ),
          body: Center(
            child: Text(
              '$name',
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(
    BuildContext context,
  ) {
    return {
      '/': (context) => _home(context),

      // NestedScreenRoutes.detail1: (context) => Scaffold(
      //       body: GestureDetector(
      //         onTap: () => _push(context, 'Page 2'),
      //         child: Text(
      //           'Page B',
      //           style: TextStyle(fontSize: 50),
      //         ),
      //       ),
      //     ),

      // NestedScreenRoutes.detail2: (context) => Scaffold(
      //       body: GestureDetector(
      //         onTap: () => _push(context, 'Page 2'),
      //         child: Text(
      //           'Page B',
      //           style: TextStyle(fontSize: 50),
      //         ),
      //       ),
      //     ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Scaffold(
      // body: _home(context)
      ///
      body: Navigator(
        key: navigatorKey,
        initialRoute: NestedScreenRoutes.root,

        /// Starting route from the onGenerateRoute map

        onGenerateRoute: (routeSettings) {
          /// Generate the route we want
          return MaterialPageRoute(
              builder: (context) => routeBuilders[routeSettings.name](context));
        },
      ),
    );
  }

  Widget _home(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => _push(context, 'Page 1'),
              child: Text(
                'Page A',
                style: TextStyle(fontSize: 50),
              ),
            ),
            GestureDetector(
              onTap: () => _push(context, 'Page 2'),
              child: Text(
                'Page B',
                style: TextStyle(fontSize: 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
