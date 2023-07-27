import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/**
 * Una de las diferencias con respecto al State Notifier Provider
 * es que no se van a utilizar 2 argumentos para definir el
 * ChangeNotifierProvider, se va a usar solo uno. Es decir, el
 * Notifier y el state son un solo objeto
 */
final todosChangeNotifierProvider = ChangeNotifierProvider<TodosChangeNotifier>((ref) => TodosChangeNotifier());


// el ChangeNotifier nos sirve para crear estados mutables
class TodosChangeNotifier extends ChangeNotifier {

// notese que no se esta llamando al constructor, esta lista se esta creando directamente desde la declaracion de la propiedad
List<Todo> todos = <Todo> [
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
];

// notese que no tenemos acceso al "state", solo tenemos acceso a las propiedades de esta clase
// tambien se debe tener en cuenta que los widgets no se van a redibujar ya que en teoria, como el
// estado muto, no es posible para nuestro todoChangeNotifyProvider saber cuando tiene que notificar
// a los demas widgets que hubo un cambio, por lo que es necesario llamar el notifier manualmente
  void addTodos(){
  
    todos = [
      ...todos,
      Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    ];
    notifyListeners();
  }

  void toggleTodo(String id) {
     
    todos = todos.map((todo){
      if(todo.id == id){
        return todo.copyWith(completedAt: todo.done ? null : DateTime.now());
      }
      return todo;
    }).toList();
    notifyListeners();
  }

}