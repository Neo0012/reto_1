// To parse this JSON data, do
//
//     final photosDto = photosDtoFromJson(jsonString);

import 'dart:convert';

PhotosDto photosDtoFromJson(String str) => PhotosDto.fromJson(json.decode(str));

String photosDtoToJson(PhotosDto data) => json.encode(data.toJson());

class PhotosDto {
  final String? title;
  final String? link;
  final String? description;
  final DateTime? modified;
  final String? generator;
  final List<Item>? items;

  PhotosDto({
    this.title,
    this.link,
    this.description,
    this.modified,
    this.generator,
    this.items,
  });

  factory PhotosDto.fromJson(Map<String, dynamic> json) => PhotosDto(
        title: json["title"],
        link: json["link"],
        description: json["description"],
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        generator: json["generator"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "description": description,
        "modified": modified?.toIso8601String(),
        "generator": generator,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  final String? title;
  final String? link;
  final Media? media;
  final DateTime? dateTaken;
  final String? description;
  final DateTime? published;
  final Author? author;
  final AuthorId? authorId;
  final String? tags;

  Item({
    this.title,
    this.link,
    this.media,
    this.dateTaken,
    this.description,
    this.published,
    this.author,
    this.authorId,
    this.tags,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        link: json["link"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        dateTaken: json["date_taken"] == null
            ? null
            : DateTime.parse(json["date_taken"]),
        description: json["description"],
        published: json["published"] == null
            ? null
            : DateTime.parse(json["published"]),
        author: authorValues.map[json["author"]]!,
        authorId: authorIdValues.map[json["author_id"]]!,
        tags: json["tags"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "media": media?.toJson(),
        "date_taken": dateTaken?.toIso8601String(),
        "description": description,
        "published": published?.toIso8601String(),
        "author": authorValues.reverse[author],
        "author_id": authorIdValues.reverse[authorId],
        "tags": tags,
      };
}

enum Author { NOBODY_FLICKR_COM_THOMASROST, NOBODY_FLICKR_COM_THOMAS_HAWK }

final authorValues = EnumValues({
  "nobody@flickr.com (\"thomasrost\")": Author.NOBODY_FLICKR_COM_THOMASROST,
  "nobody@flickr.com (\"Thomas Hawk\")": Author.NOBODY_FLICKR_COM_THOMAS_HAWK
});

enum AuthorId { THE_16338968_N00, THE_51035555243_N01 }

final authorIdValues = EnumValues({
  "16338968@N00": AuthorId.THE_16338968_N00,
  "51035555243@N01": AuthorId.THE_51035555243_N01
});

class Media {
  final String? m;

  Media({
    this.m,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        m: json["m"],
      );

  Map<String, dynamic> toJson() => {
        "m": m,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
