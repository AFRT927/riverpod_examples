
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';

/**
 * Provider: es el provider de riverpod que es de solo
 * lectura, esto significa que si estoy en algun widget
 * y toco un boton, NO voy a poder cambiar este provider
 * de manera directa.
 * 
 * si se quiere modificar el provider, se debe utilizar
 * la propiedad "autodispose". El autodispos realmente
 * lo que hace es que se limpie este provider cuando ya
 * no se este usando. En este caso, al limpiarlo, obliga
 * a que la proxima vez que se renderice la pantalla,
 * se vuelva a ejecutar el simpleNameProvider y por
 * lo tanto se genere un nombre nuevo
 * 
 * si se quiere mandar algun valor al provider, se debe
 * usar la propiedad "family".
 */
final simpleNameProvider = Provider.autoDispose<String>((ref){
  return RandomGenerator.getRandomName();
}); 