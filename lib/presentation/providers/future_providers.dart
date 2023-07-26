import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

final pokemonNameProvider = FutureProvider.autoDispose<String>((ref) async {

  final pokemonId = ref.watch(pokemonIdProvider);
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);
  return pokemonName;
});

final pokemonIdProvider = StateProvider.autoDispose<int>((ref){
return 1;
});


final pokemonNameProviderF = FutureProvider.family<String, int>((ref, pokemonId) async {
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);
  return pokemonName;
});
