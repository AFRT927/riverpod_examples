import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: StreamView(),
    );
  }
}

class StreamView extends ConsumerWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   // ojo: "usersStream" es un valor asincrono
   final usersStream = ref.watch(usersInChatProvider);

    if (!usersStream.hasValue) {
       return Center(
        child: CircularProgressIndicator(),
       );
    }

    return ListView.builder(
      itemCount: usersStream.value!.length ?? 0,
      itemBuilder: (BuildContext context, i) {
        final name = usersStream.value![i];
        return ListTile(
          title: Text(name),
        );
      }
      );
  }
}