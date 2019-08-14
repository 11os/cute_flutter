import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Api {
  final HttpLink httpLink = HttpLink(
    uri: 'https://api.github.com/graphql',
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );
  get link => authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> get client => ValueNotifier(
        GraphQLClient(
          cache: InMemoryCache(),
          link: link,
        ),
      );
}
