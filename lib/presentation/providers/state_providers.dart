import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

/**
 * StateProviders: Este es uno de los providers mas comunes
 * por que es un provider que nos permite poder cambiarlo
 * sirve para mantener el valor de un objeto (stateholder),
 * ya sea una clase personalizada, una lista, un string, un 
 * valor booleano, lo que sea.
 */

final counterProvider = StateProvider.autoDispose<int>((c){
  /**
   * Ojo, esta funcion solo computa el estado inicial del counterProvider.
   * los demas estados van a ser computados por la funcion que se le pase
   * al update.
   * 
   * el autoDispose se le agrega para que el estado se resetee cada que se
   * salgan de esta pantalla.
   */
  return 0;
  }); 

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final nameGeneratorProvider = StateProvider<String>(
  (ref) => RandomGenerator.getRandomName()
  );