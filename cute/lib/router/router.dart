import 'dart:convert';

import 'package:cute/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Router {
  // flutter singleton
  static final Router i = Router._internal();
  factory Router() => i;
  Router._internal();

  /// 打开页面
  /// Router.push(context, 'mq://manqian.com/home');
  static push(context, routeName, {Map arguments}) {
    Navigator.pushNamed(context, routeName, arguments: jsonEncode(arguments));
  }

  /// 关闭页面
  /// Router.finish(context);
  static pop(context) {
    Navigator.pop(context);
  }

  ///
  static init() => (RouteSettings settings) => CupertinoPageRoute(
        builder: (context) {
          switch (settings.name) {
            case 'cute://detail':
              return DetailPage(arguments: settings.arguments);
            default:
              return null;
          }
        },
      );
}
