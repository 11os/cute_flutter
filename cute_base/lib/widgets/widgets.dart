import 'dart:convert';

import 'package:flutter/widgets.dart';

abstract class CStatelessWidget extends StatelessWidget {
  final String arguments;
  Map get params => jsonDecode(arguments);
  CStatelessWidget({Key key, this.arguments}) : super(key: key);
}

abstract class CStatefulWidget extends StatefulWidget {
  final String arguments;
  Map get params => jsonDecode(arguments);
  CStatefulWidget({Key key, this.arguments}) : super(key: key);
}
