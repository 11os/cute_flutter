import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Api {
  final HttpLink httpLink = HttpLink(
    uri: 'https://api.github.com/graphql',
  );
  final AuthLink authLink = AuthLink(
    // getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    // OR
    getToken: () => 'Bearer 1cd2b6658eabaef1dab475c80e37f4feaf47159a',
  );
  get link => authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> get widgetClient => ValueNotifier(client);

  GraphQLClient get client => GraphQLClient(cache: InMemoryCache(), link: link);
}

class RequestError extends Error {
  final code;
  final msg;
  RequestError(this.code, this.msg);
}
