import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reto_deber/src/data/domain/repository_photos.dart';

class RepositoryPhotosImpl extends RepositoryPhotos {
  final Dio _dioDirections = Dio(); // Renombrado para mayor claridad
  final String _baseDirectionsUrl =
      'https://api.flickr.com/services/feeds/photos_public.gne'; // URL base de Flickr

  @override
  Future<void> getDataPhotos() async {
    try {
      final response = await _dioDirections.get(
        _baseDirectionsUrl,
        queryParameters: {
          'tags': 'priime',
          'format': 'json',
          //'nojsoncall': '1', // Asegura que el resultado sea JSON puro
        },
      );

      // Procesar los datos obtenidos
      final data = jsonDecode(response.data);
      print('Datos obtenidos de la API: $data');
    } catch (e) {
      print('Error desconocido: $e');
    }
  }
}
