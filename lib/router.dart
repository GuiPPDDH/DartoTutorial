import 'package:darto/darto.dart';
import 'package:darto_tutorial/controllers/todo_controller.dart';
import 'package:darto_tutorial/middlewares/logger_middleware.dart';

Router rootRouter() {
  final router = Router();
  final todoController = TodoController();

  router.get('/todos', loggerMiddleware, todoController.getAll);
  router.post('/todos', loggerMiddleware, todoController.create);
  router.put('/todos/:id', loggerMiddleware, todoController.update);
  router.delete('/todos/:id', loggerMiddleware, todoController.delete);

  return router;
}
