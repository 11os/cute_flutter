import 'package:cute/apis/resp.dart';
import 'package:cute/router/router.dart';
import 'package:cute/widgets/refresh.dart';
import 'package:cute_base/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FirstPage extends CStatefulWidget {
  FirstPage({Key key, arguments}) : super(key: key, arguments: arguments);
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List _list = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    QueryResult resp = await Resp().getList();
    if (resp.hasErrors) {
      print('${resp.errors}');
    } else {
      Map data = resp.data;
      setState(() {
        _list = data['search']['nodes'];
      });
      print(data);
    }
  }

  _onRefresh() async {
    try {
      await _initData();
    } catch (e) {} finally {
      _refreshController.refreshCompleted();
    }
  }

  _onLoading() async {
    try {} catch (e) {
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: RefreshHeader(),
        footer: RefreshFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _renderListView(),
      ),
    );
  }

  ListView _renderListView() => ListView(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        children: <Widget>[
          ..._list.map(
            (ele) => GestureDetector(
              child: _renderListItem(ele),
              onTap: () =>
                  Router.push(context, 'cute://detail', arguments: ele),
            ),
          )
        ],
      );

  Container _renderListItem(ele) => Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x14000000),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(ele['nameWithOwner'] ?? ''),
                Text('Star ${ele['stargazers']['totalCount'] / 1000}k' ?? ''),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${ele['url']}',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text('${ele['description']}'),
          ],
        ),
      );
}
