import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reto_deber/src/data/domain/photos_entity.dart';
import 'package:reto_deber/src/data/domain/repository_photos.dart';
import 'package:reto_deber/src/data/infrastructure/photos.dart';

class RepositoryPhotosImpl extends RepositoryPhotos {
  final Dio _dioPhotos = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent':
            'MyApp/1.0.0 (https://myapp.com)', // Agregar el user agent para que te permita hacer la petición, esto es debido al server que estes utilizando.
      },
    ),
  ); // Renombrado para mayor claridad/ Renombrado para mayor claridad
  final String _basePhotosUrl =
      'https://api.flickr.com/services/feeds/photos_public.gne'; // URL base de Flickr

  @override
  Future<List<PhotosEntity>> getDataPhotos() async {
    try {
      final response = await _dioPhotos.get(
        _basePhotosUrl,
        queryParameters: {
          'tags': 'priime',
          'format': 'json',
          //'nojsoncall': '1', // Asegura que el resultado sea JSON puro
        },
      );

      // Si la respuesta contiene un prefijo como `jsonFlickrFeed(...)`
      String rawResponse = response.data as String;
      if (rawResponse.startsWith('jsonFlickrFeed(')) {
        // Eliminar el prefijo `jsonFlickrFeed(` y el sufijo `)`
        rawResponse = rawResponse.substring(
          'jsonFlickrFeed('.length,
          rawResponse.length - 1,
        );
      }

      // Convertir el JSON puro a un Map
      final Map<String, dynamic> jsonData = jsonDecode(rawResponse);
      final data = PhotosDto.fromJson(jsonData);

      // Procesar la lista de fotos
      final List<PhotosEntity> photos = data.items
              ?.map((item) => PhotosEntity(
                    imageUrl: item.media?.m,
                    tags: item.tags,
                  ))
              .toList() ??
          [];

      return photos;
    } catch (e) {
      print('Error desconocido: $e');
      // Retorna una lista vacía en caso de error
      return [];
    }
  }
}
