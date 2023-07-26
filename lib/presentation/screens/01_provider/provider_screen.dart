import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';



//====[leyendo un provider por medio de un stateless widget]====//
// class ProviderScreen extends ConsumerWidget {
//   const ProviderScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

      // es necesario pasar el ref como argumento del build
//    final String sName = ref.watch(simpleNameProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider'),
//       ),
//       body: Center(
//         child: Text(sName),
//       ),
//     );
//   }
// }


//====[leyendo un provider por medio de un statefull widget]====//
class ProviderScreen extends ConsumerStatefulWidget {
  const ProviderScreen({super.key});

  @override
  ProviderScreenState createState() => ProviderScreenState();
}

class ProviderScreenState extends ConsumerState<ProviderScreen> {
  @override
  Widget build(BuildContext context) {
    
    /**
     * cuando se utiliza ConsumeStatefulWidget, NO es necesario
     * pasar el ref como argumento del metodo build.
     * 
     * sin haber pasado el ref, ya tenemos acceso a el.
     */
    final String sName = ref.watch(simpleNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: Text(sName),
      ),
    );;
  }
}

