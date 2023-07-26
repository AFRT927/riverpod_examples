import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/**
 * StateNotifierProvider: el StateNotifierProvider consta de 
 * tres partes:
 * 
 * 1) el estado, que es del tipo de dato que va a manejar el Notifier
 * 2) el notifier que es quien notifica a los demas widgets que estan escuchandolo
 * 3) el provider
 * 
 * Syntaxis:  
 * //---------------------------------------(3)--------------(2)-------(1)--------------
 * final myStateNotifierProvider = StateNotifierProvider<Notificador, Estado>((ref){ });
 * 
 * La sintaxis muestra claramente cada una de las partes
 * 
 */






// clase del notifier, cumple con el rol (2). Tambien es llamado controller
/**
 * Clase del Notifier: cumple con el rol (2). Tambien es llamado controller,
 * pero el nombre ideal deberia ser Notifier.
 * 
 * partes del Notifier:
 * 
 * 2.1) tipo de dato que va a ser manejado pir el Notifier, en este caso
 *      el tipo List<Todo>, pero se puede manejar cualquier tip de dato
 *      inclusive clases personalizadas
 * 
 * 2.2) el notifier me exige inicializar a su clase padre por medio del super,
 *      en este caso lo vamos a inicializar con una lista de 3 Todos, sin embargo
 *      se podria inicializar con un array vacio.
 * 
 * 2.3) metodo para ejecutar la accion deseada
 * 
 * 2.4) la variable state me permite actualizar el estado (que es del tipo
 *      definido en 2.1) y adicionalmente, cuando el state cambia o se actualiza,
 *      inmediatamente se notifica a todos los que esten escuchando.
 *      En este caso en particular, se esta añadiendo un solo Todo cada vez que
 *      se manda a ejecutar la funcion addTodos().
 */

//-------------------------------------------(2.1)----
class TodosNotifier extends StateNotifier<List<Todo>> {

  //--------------(2.2)---------
  TodosNotifier():super([
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
  ]);

  //-----------(2.3)------------
  void addTodos(){

  //--(2.4)--------
    state = [
      ...state,
      Todo(id: _uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    ];

  }

  void toggleTodo(String id) {
     
    state = state.map((todo){
      if(todo.id == id){
        return todo.copyWith(completedAt: todo.done ? null : DateTime.now());
      }
      return todo;
    }).toList();

  }

}

// definicion del provider
final todosStateNotifierProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();// creacion de la instancia Notifier
});


// Provider to avoid reading the filters results
final FilteredTodosUsingSNP = Provider<List<Todo>>((ref){
  final todos = ref.watch(todosStateNotifierProvider);
  final selectedFiler = ref.watch(todoFilterProvider);
  switch (selectedFiler) {
    case TodoFilter.all:
      return todos;

    case TodoFilter.completed:
      return todos.where((t) => t.done).toList();

    case TodoFilter.pending:
      return todos.where((t) => !t.done).toList();      
    
  }
});