import 'package:cute/apis/api.dart';
import 'package:cute/router/router.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'pages/first_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Api().widgetClient,
      child: MaterialApp(
        onGenerateRoute: Router.init(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const _tabList = const [
  Tab(icon: Icon(Icons.home)),
  Tab(icon: Icon(Icons.favorite)),
  Tab(icon: Icon(Icons.more)),
  Tab(icon: Icon(Icons.perm_identity)),
];

var _viewList = <Widget>[
  FirstPage(),
  Container(),
  Container(),
  Container(),
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: Scaffold(
          bottomNavigationBar: SafeArea(
            child: TabBar(
              tabs: _tabList,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              indicatorColor: Colors.transparent,
            ),
          ),
          body: TabBarView(
            children: _viewList,
          )),
    );
  }
}
