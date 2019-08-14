Map queryToMap(String arguements) {
  Map result = Map();
  if (null != arguements && arguements.isNotEmpty) {
    var array = arguements.split('&');
    array
        .asMap()
        .forEach((index, ele) => result[ele.split('=')[0]] = ele.split('=')[1]);
  }
  return result;
}

String getParams(String path) {
  var array = path.split('?');
  return array.length > 0 ? array[1] : '';
}
