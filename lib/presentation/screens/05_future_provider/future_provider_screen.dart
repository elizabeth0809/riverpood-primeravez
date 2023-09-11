import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonName = ref.watch(pokemonNameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
        child: pokemonName.when(
          data: (data) => Text(data),
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text('$error')
        )
      ),
      floatingActionButton:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
           FloatingActionButton(
            heroTag: 'btn1',
        child: const Icon( Icons.refresh ),
        onPressed: () { 
          ref.read(pokemonIdProvider.notifier).nextPokemon();
         },
      ),
       FloatingActionButton(
        child: const Icon( Icons.more ),
        onPressed: () { 
          ref.read(pokemonIdProvider.notifier).prevPokemon();
         },
      ),
        ],
      )
    );
  }
}