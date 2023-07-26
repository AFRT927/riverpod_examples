import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  ConsumerState<FamilyFutureScreen> createState() => FamilyFutureScreenState();
}

class FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {

  /**
   * se utiliza un statefull widget justamente por que NO
   * es posible cambiar el valor del pokemonId sin usar 
   * un SetState
   */

  int pokemonId = 1;

  @override
  Widget build(BuildContext context) {

    final  pokemonAsync = ref.watch( pokemonNameProviderF(pokemonId) );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Future Provider'),
      ),
      body: Center(
        child: pokemonAsync.when(
          data: (data) => Text(data), 
          error: (_,__) => const Text('No se encontro el pokemon'), 
          loading: () => const CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.refresh ),
        onPressed: () {  
            setState(() {
              pokemonId++;
            });
        }
      ),
    );
  }
}