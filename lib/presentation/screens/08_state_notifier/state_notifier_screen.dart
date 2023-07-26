import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:riverpod_app/presentation/providers/todos_state_notifier_provider.dart';


class StateNotifierScreen extends ConsumerWidget {
  const StateNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: TodosView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
              // usando el state Notifier Provider
              ref.read(todosStateNotifierProvider.notifier).addTodos();
        }
        ),
    );
  }
}

class TodosView extends ConsumerWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentFilter = ref.watch(todoFilterProvider);
    //final todos = ref.watch(todosStateNotifierProvider);
    final todos = ref.watch(FilteredTodosUsingSNP);
        return Column(
      children: [


        SegmentedButton(
          segments: const[
            ButtonSegment(value: TodoFilter.all, icon: Text('Todos')),
            ButtonSegment(value: TodoFilter.completed, icon: Text('Invitados')),
            ButtonSegment(value: TodoFilter.pending, icon: Text('No invitados')),
          ], 
          selected: <TodoFilter>{ currentFilter },
          onSelectionChanged: (value) {
            /**
             * cuando se actualizan estados del tipo enum, es mas
             * facil hacerlo con la notacion .state
             */
            ref.read(todoFilterProvider.notifier).state = value.first;       
            //ref.read(filteredTodosProvider.notifier).update((state) => todoList.);     
          },
        ),
        const SizedBox( height: 5 ),

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
                ref.read(todosStateNotifierProvider.notifier).toggleTodo(todos[index].id);

                }
              );
            },
          ),
        )
      ],
    );
  }
}