import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/helpers/random_generator.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todoList = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider + Providers'),
      ),
      body: const _TodoView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.add ),
        onPressed: () {
          ref.read(todosProvider.notifier).update((state) => [
            ...todoList,
            Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null)
          ]);
        },
      ),
    );
  }
}


class _TodoView extends ConsumerWidget {
  const _TodoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentFilter = ref.watch(todoFilterProvider);
    final todoList = ref.watch(todosProvider);
    final filteredTodos = ref.watch(filteredTodosProvider);

    return Column(
      children: [
        const ListTile(
          title: Text('Listado de invitados'),
          subtitle: Text('Estas son las personas a invitar a la fiesta'),
        ),

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

        /// Listado de personas a invitar
        Expanded(
          child: ListView.builder(
            itemCount: filteredTodos.length,
            itemBuilder: (context, index) {
              return SwitchListTile(
                title: Text(filteredTodos[index].description),
                value: filteredTodos[index].done, 
                onChanged: ( value ) {
                  ref.read(todosProvider.notifier).update((state) => todoList.map((t) {
                    if(t.id == filteredTodos[index].id ){
                        return t.copyWith(completedAt: t.done ? null : DateTime.now());
                    }
                    return t;
                  }).toList());
                }
              );
            },
          ),
        )
      ],
    );
  }
}