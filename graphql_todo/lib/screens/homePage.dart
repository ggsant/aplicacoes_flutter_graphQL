import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_todo/screens/userPage.dart';

import 'createTodoPage.dart';

class HomePage extends StatelessWidget {
  /*
  * Executando operação de consulta
  * A operação de consulta é básica no GraphQL, usada para ler/buscar os dados do servidor. Esta é a operação de leitura de 4 operações CRUD básicas. Primeiro, definimos a operação de consulta exata para o nosso com o conjunto de seleção de que precisamos. A operação de consulta a seguir irá buscar a lista de todos os campos definidos.
  */

  final String fetchTodos = """ 
  query {
    todos {
      id
      title
      description
      createTime
      deadLine
      createdBy {
        id
        name
      }
    }
  }
  """;

  /*
  Deletando um Todo: Para deletar, primeiro vamos escrever uma string de mutação que é definida como feito abaixo:
  */
  final String deleteTodo = """ 
  mutation DeleteTodo(\$id: ID!) {
    action: deleteTodo(id: \$id) {
      id
      title
      description
      createTime
      deadline
      createdBy {
        id
        name
        email
      }
    }
  }
  """;

  /*
  Agora, novamente o mesmo é o procedimento, envolveremos o elemento / widget de UI dentro do widget Mutation e runMutation () será a chave novamente para realizar a operação de exclusão. Abaixo está o exemplo de código para isso.

  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Flutter & GraphQl"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.supervised_user_circle),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserPage()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTodoPage("", "", "", "")));
        },
      ),
      body: Container(
          child: Query(
        options: QueryOptions(documentNode: gql(fetchTodos)),
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

          List todos = result.data['todos'];

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return ExpansionTile(
                title: Text(
                  todo['title'],
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(todo['description'].toString()),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Chip(
                              avatar: Icon(Icons.timer),
                              label: Text(todo['createTime']),
                            ),
                            Chip(
                              avatar: Icon(Icons.av_timer),
                              label: Text(todo['deadline']),
                            ),
                          ],
                        ),
                        Center(
                          child: Chip(
                            label: Text(todo['createdBy']['name']),
                            avatar: Icon(Icons.account_circle),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              child: Row(
                                children: [Icon(Icons.edit), Text("Edit Todo")],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateTodoPage(
                                          todo['id'],
                                          todo['title'],
                                          todo['description'],
                                          todo['deadline']),
                                    ));
                              },
                            ),
                            Mutation(
                              options: MutationOptions(
                                  documentNode: gql(deleteTodo),
                                  onCompleted: (dynamic resultData) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }),
                              builder: (RunMutation runMutation,
                                  QueryResult result) {
                                return RaisedButton(
                                  child: Text(
                                    "Delete Todo",
                                  ),
                                  onPressed: () {
                                    runMutation({
                                      'id': todo['id'],
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      )),
    );
  }
}
