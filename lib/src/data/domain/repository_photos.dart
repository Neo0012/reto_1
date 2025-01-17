import 'package:reto_deber/src/data/domain/photos_entity.dart';

abstract class RepositoryPhotos {
  Future<List<PhotosEntity>> getDataPhotos();
}
