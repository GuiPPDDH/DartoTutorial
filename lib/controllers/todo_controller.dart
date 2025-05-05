import 'package:darto/darto.dart';

class TodoController {
  int _idCounter = 1;
  final List _todos = [];

  Future<void> getAll(Request request, Response response) async {
    return response.status(200).json(_todos);
  }

  Future<void> create(Request request, Response response) async {
    final body = await request.body;
    final todo = {
      'id': _idCounter++,
      'title': body['title'],
      'completed': false,
    };

    _todos.add(todo);

    return response.status(201).end();
  }

  Future<void> update(Request request, Response response) async {
    final id = int.parse(request.params['id'] ?? '');
    final body = await request.body;

    final indexTodo = _todos.indexWhere((todo) => todo['id'] == id);

    if (indexTodo != -1) {
      final todoToUpdate = _todos[indexTodo];
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
  }

  Future<void> delete(Request request, Response response) async {
    final id = int.parse(request.params['id'] ?? '');

    final indexTodo = _todos.indexWhere((todo) => todo['id'] == id);

    if (indexTodo != -1) {
      _todos.removeAt(indexTodo);

      return response.status(204).end();
    } else {
      return response.status(404).json({
        'message': 'Todo não encontrado',
      });
    }
  }
}
