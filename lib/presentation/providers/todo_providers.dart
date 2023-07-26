import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:uuid/uuid.dart';

enum TodoFilter {
  all,
  completed,
  pending
}

const uuid = Uuid();

final StateProvider<TodoFilter> todoFilterProvider = StateProvider<TodoFilter>(
  (ref){
    return TodoFilter.all;
  });

  final StateProvider<List<Todo>> todosProvider = StateProvider<List<Todo>>((ref){
    return [
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      ];
  });

  final filteredTodosProvider =  Provider<List<Todo>>((ref){

    /**
     * Ojo: siempre que se quiera acceder a un provider desde 
     * otro provider, se debe hacer por medio del metodo "watch"
     * 
     * Notese que se esta usando un Provider, no un StateProvider
     * Esto debido a que el filteredTodoProvider no se va a actualizar,
     * simplemente mostrara lo que se se vaya filtrando sin necesidad de
     * regenerarse.
     */
    final selectedFilter = ref.watch(todoFilterProvider);
    final todos = ref.watch(todosProvider);

    switch (selectedFilter) {
      case TodoFilter.all:
        return  todos;        

      case TodoFilter.completed:
        return  todos.where((element) => element.done).toList();       

      case TodoFilter.pending:
        return  todos.where((element) => !element.done).toList(); 
       
      default:
      return  todos;
    }
  });