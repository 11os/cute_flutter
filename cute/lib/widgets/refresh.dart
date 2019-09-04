import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends ClassicHeader {
  RefreshHeader()
      : super(
          idleText: '下拉刷新',
          releaseText: '释放刷新',
          completeText: '',
          refreshingText: '更新中',
          completeIcon: null,
          completeDuration: Duration(seconds: 0),
        );
}

class RefreshFooter extends ClassicFooter {
  RefreshFooter()
      : super(
          loadingText: '加载中',
          noDataText: '没有更多了',
          idleText: '上拉加载更多',
          failedText: '加载失败，点击重试',
        );
}
