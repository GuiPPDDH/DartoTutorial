import 'package:darto/darto.dart';

void main() {
  final darto = Darto();

  int idCounter = 1;
  List todos = [];

  //Método GET /todos
  darto.get('/todos', (Request request, Response response) async {
    return response.status(200).json(todos);
  });

  //Método POST /todos
  darto.post('/todos', (Request request, Response response) async {
    final body = await request.body;
    final todo = {
      'id': idCounter++,
      'title': body['title'],
      'completed': false,
    };

    todos.add(todo);

    return response.status(201).end();
  });

  //Método PUT /todos/:id
  darto.put('/todos/:id', (Request request, Response response) async {
    final id = int.parse(request.params['id'] ?? '');
    final body = await request.body;

    final indexTodo = todos.indexWhere((todo) => todo['id'] == id);

    if (indexTodo != -1) {
      final todoToUpdate = todos[indexTodo];
      todoToUpdate.addAll(body);

      return response.status(200).json(todoToUpdate);
    } else {
      return response.status(404).json({
        'message': 'Todo não encontrado',
      });
      //   todos[indexTodo] = {
      //     'id': id,
      //     ...todos[indexTodo],
      //     ...body,
      //   };

      //   return response.status(200).json(todos[indexTodo]);
      // } else {
      //   return response.status(404).json({
      //     'message': 'Todo não encontrado',
      //   });
      // }
    }
  });

  //Método DELETE /todos/:id
  darto.delete('/todos/:id', (Request request, Response response) async {
    final id = int.parse(request.params['id'] ?? '');

    final indexTodo = todos.indexWhere((todo) => todo['id'] == id);

    if (indexTodo != -1) {
      todos.removeAt(indexTodo);

      return response.status(204).end();
    } else {
      return response.status(404).json({
        'message': 'Todo não encontrado',
      });
    }
  });

  darto.listen(3000, () {
    print('API com Darto rodando na porta 3000');
  });
}
