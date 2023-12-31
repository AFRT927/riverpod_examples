import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final counter = ref.watch(counterProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);
    final name = ref.watch(nameGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 1,),

            IconButton(
              // icon: const Icon( Icons.light_mode_outlined, size: 100 ),
              icon: Icon( isDarkMode? Icons.light_mode_outlined : Icons.dark_mode_outlined, size: 100 ),
              onPressed: () {
                ref.read(isDarkModeProvider.notifier).update((state) => !state);
              },
            ),

            Text( name, style: const TextStyle(fontSize: 25 )),

            TextButton.icon(
              icon: const Icon( Icons.add, size: 50,),
              label: Text('$counter', style: const TextStyle(fontSize: 100)),
              onPressed: () {

                /**
                 * se debe llamar al notifier del provider para notificar a todas
                 * las partes de la app que utilicen este provider, de que su estado
                 * ha cambiado
                 */
                ref.read(counterProvider.notifier).update((state) => state + 1);
              },
            ),
            
            const Spacer( flex: 2 ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nombre aleatorio'),
        icon: const Icon( Icons.refresh_rounded ),
        onPressed: () {
          /**
           * al invalidarlo, le estoy ordenando que vuelva a ejecutar
           * la funcion que computa el estado inicial del stateProvider
           * nameGeneratorProvider.
           *  */ 
          ref.invalidate(nameGeneratorProvider);
        },
      ),
    );
  }
}