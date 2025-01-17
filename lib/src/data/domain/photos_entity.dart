// Modelo para representar las fotos
class PhotosEntity {
  final String? imageUrl;
  final String? tags;

  PhotosEntity({this.imageUrl, this.tags});

  factory PhotosEntity.fromJson(Map<String, dynamic> json) {
    return PhotosEntity(
      imageUrl: json['media']?['m'],
      tags: json['tags'],
    );
  }
}
