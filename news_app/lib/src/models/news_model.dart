
import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  List<NewsElement> news;

  News({
    required this.news,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    news: List<NewsElement>.from(json["news"].map((x) => NewsElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class NewsElement {
  int id;
  String title;
  String slug;
  String category;
  String? city;
  String state;
  String? description;
  String? videoUrl;
  String? embedCode;
  NewsType newsType;
  String? file;
  String? coverPhoto;
  String? metaDescription;
  String? metaKeywords;
  String userId;
  String uniqueKey;
  Status status;
  int views;
  DateTime createdAt;
  DateTime updatedAt;

  NewsElement({
    required this.id,
    required this.title,
    required this.slug,
    required this.category,
    required this.city,
    required this.state,
    required this.description,
    required this.videoUrl,
    required this.embedCode,
    required this.newsType,
    required this.file,
    required this.coverPhoto,
    required this.metaDescription,
    required this.metaKeywords,
    required this.userId,
    required this.uniqueKey,
    required this.status,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsElement.fromJson(Map<String, dynamic> json) => NewsElement(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    category: json["category"],
    city: json["city"],
    state: json["state"],
    description: json["description"],
    videoUrl: json["video_url"],
    embedCode: json["embed_code"],
    newsType: newsTypeValues.map[json["news_type"]]!,
    file: json["file"],
    coverPhoto: json["cover_photo"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    userId: json["user_id"],
    uniqueKey: json["unique_key"],
    status: statusValues.map[json["status"]]!,
    views: json["views"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category": category,
    "city": city,
    "state": state,
    "description": description,
    "video_url": videoUrl,
    "embed_code": embedCode,
    "news_type": newsTypeValues.reverse[newsType],
    "file": file,
    "cover_photo": coverPhoto,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "user_id": userId,
    "unique_key": uniqueKey,
    "status": statusValues.reverse[status],
    "views": views,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum NewsType {
  BLOG,
  VIDEO_NEWS
}

final newsTypeValues = EnumValues({
  "Blog": NewsType.BLOG,
  "Video News": NewsType.VIDEO_NEWS
});

enum Status {
  DRAFT,
  PUBLISH,
  UNDER_REVIEW
}

final statusValues = EnumValues({
  "Draft": Status.DRAFT,
  "Publish": Status.PUBLISH,
  "Under Review": Status.UNDER_REVIEW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
