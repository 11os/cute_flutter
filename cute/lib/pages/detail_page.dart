import 'package:cute_base/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends CStatefulWidget {
  DetailPage({Key key, arguments}) : super(key: key, arguments: arguments);
  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomScrollView'),
        elevation: 0, // bottom shadow
      ),
      body: _renderBody(),
    );
  }

  _renderBody() => CustomScrollView(
        slivers: <Widget>[
          // header
          _renderHeader(),
          // fix tab
          _renderFixedHeader(),
          // content
          _renderContent(),
          // footer
          _renderFooter()
        ],
      );

  _renderHeader() => SliverToBoxAdapter(
        child: Container(
          color: Colors.grey,
          padding: EdgeInsets.all(100),
          child: Column(
            children: <Widget>[
              Image(
                height: 80,
                width: 80,
                image: NetworkImage(widget.params['owner']['avatarUrl']),
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent loadingProgress,
                ) {
                  return null == loadingProgress
                      ? child
                      : CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 20,
              ),
              // Text('arguement: ${widget.arguments}'),
              // Text('params: ${widget.params}'),
              Text(
                  'params["nameWithOwner"]: ${widget.params['nameWithOwner']}'),
            ],
          ),
        ),
      );

  _renderFixedHeader() => SliverPersistentHeader(
        pinned: true,
        delegate: _FixedTabDelegate(),
      );

  _renderContent() => SliverToBoxAdapter(
        child: Container(
          color: Colors.yellow,
          height: MediaQuery.of(context).size.height * 1.2,
        ),
      );

  _renderFooter() => SliverToBoxAdapter(
        child: Container(
          height: 40,
          color: Colors.red,
        ),
      );
}

class _FixedTabDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('fixed title'),
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
