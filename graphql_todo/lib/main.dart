import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'screens/homePage.dart';

void main() => runApp(ToDoList());

class ToDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink link = HttpLink(uri: "");

    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ));

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: ThemeData(primaryColor: Colors.purple[300]),
        ));
  }
}

/*
* Conectando-se ao servidor
* Antes de mais nada, a conexão com o servidor é a parte mais importante. Então, para isso, estaremos envolvendo toda a nossa aplicação, ou seja, o widget MaterialApp em um widget chamado GraphQLProvider que é definido no pacote graphql_flutter.
*/
