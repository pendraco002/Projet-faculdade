import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

class FunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: 'us-central1');

  Future<HttpsCallableResult?> callFunction(String name, [Map<String, dynamic>? params]) async {
    try {
      final callable = _functions.httpsCallable(name);
      final results = await callable.call(params);
      return results;
    } on FirebaseFunctionsException catch (e) {
      debugPrint('Erro ao chamar a Cloud Function $name:');
      debugPrint('Código: ${e.code}');
      debugPrint('Mensagem: ${e.message}');
      return null;
    }
  }
}
