import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/*
* Agora, depois de definir a consulta na home page,devemos usar essa operação de consulta na IU, que pode ser obtida a partir do código abaixo. Aqui, um widget Query é usado, o qual é definido no pacote graphql_flutter e usado para realizar a operação Query no GraphQL. É como usar o widget Query envolvendo o widget que deve ser renderizado e o widget empacotado terá acesso aos dados gerados pelo widget Query. Estamos usando a consulta acima dentro da função gql como um parâmetro. O pacote graphql_flutter vem com várias funcionalidades relacionadas à operação de consulta GraphQL. Tudo isso pode ser explorado na documentação.
*/
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final String fetchUsers = """
    query {
      users {
        id
        name
        email
        todos {
          id
          title
          description
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios"),
        centerTitle: true,
      ),
      body: Container(
        child: Query(
            options: QueryOptions(documentNode: gql(fetchUsers)),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Center(
                  child: Text(result.exception.toString()),
                );
              }

              if (result.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List users = result.data['users'];
              print(users);

              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user['nome']),
                      subtitle: Text(user['email']),
                      trailing: Chip(
                        label: Text(user['todos'].length.toString()),
                        avatar: Icon(
                          Icons.mode_edit,
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
