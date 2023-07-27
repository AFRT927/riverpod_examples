import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';



class ChangeNotifierScreen extends ConsumerWidget {
  const ChangeNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Provider'),
      ),
      body: TodoschangeNotView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
              // usando el state Notifier Provider
              ref.read(todosChangeNotifierProvider).addTodos();
        }
        ),
    );
  }
}

class TodoschangeNotView extends ConsumerWidget {
  const TodoschangeNotView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //final currentFilter = ref.watch(todoFilterProvider);
    final todosChangeNotifier = ref.watch(todosChangeNotifierProvider);
    final todos = todosChangeNotifier.todos;
    //final todos = ref.watch(FilteredTodosUsingSNP);
        return Column(
      children: [

        // Listado de personas a invitar
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return SwitchListTile(
                title: Text(todos[index].description),
                value: todos[index].done, 
                onChanged: ( value ) {
                  /*
                  // sin state Notifier Provider, usando solo el StateProvider
                  ref.read(todosProvider.notifier).update((state) => todoList.map((t) {
                    if(t.id == filteredTodos[index].id ){
                        return t.copyWith(completedAt: t.done ? null : DateTime.now());
                    }
                    return t;
                  }).toList());
                  */
                ref.read(todosChangeNotifierProvider.notifier).toggleTodo(todos[index].id);

                }
              );
            },
          ),
        )
      ],
    );
  }
}