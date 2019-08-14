import 'package:cute/apis/api.dart';
import 'package:cute/router/router.dart';
import 'package:cute_base/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FirstPage extends CStatefulWidget {
  FirstPage({Key key, arguments}) : super(key: key, arguments: arguments);
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final queryList = """
    {
      search(query: "react", type: REPOSITORY, first: 10) {
        repositoryCount
        nodes {
          ... on Repository {
            nameWithOwner
            url
            description
            owner {
              avatarUrl
              login
            }
            owner {
              avatarUrl
              login
            }
            stargazers {
              totalCount
            }
          }
        }
      }
    }
  """;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: _renderListView(),
    );
  }

  Query _renderListView() => Query(
        options: QueryOptions(
          document: queryList,
          variables: {},
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          final data = result.data;
          if (null == data) return Container();
          return ListView(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            children: <Widget>[
              ...data['search']['nodes'].map(
                (ele) => GestureDetector(
                  child: _renderListItem(ele),
                  onTap: () =>
                      Router.push(context, 'cute://detail', arguments: ele),
                ),
              )
            ],
          );
        },
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
