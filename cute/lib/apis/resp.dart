import 'package:cute/apis/api.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Resp {
  getList({variables}) {
    const query = """{
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
    }""";
    return Api()
        .client
        .query(QueryOptions(document: query, variables: variables));
  }
}
