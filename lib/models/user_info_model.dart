// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  int? id;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? url;
  String? description;
  String? link;
  String? locale;
  String? nickname;
  String? slug;
  List<String>? roles;
  DateTime? registeredDate;
  Capabilities? capabilities;
  ExtraCapabilities? extraCapabilities;
  Map<String, String>? avatarUrls;
  Meta? meta;
  Links? links;

  UserInfoModel({
    this.id,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.url,
    this.description,
    this.link,
    this.locale,
    this.nickname,
    this.slug,
    this.roles,
    this.registeredDate,
    this.capabilities,
    this.extraCapabilities,
    this.avatarUrls,
    this.meta,
    this.links,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        locale: json["locale"],
        nickname: json["nickname"],
        slug: json["slug"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
        registeredDate: json["registered_date"] == null
            ? null
            : DateTime.parse(json["registered_date"]),
        capabilities: json["capabilities"] == null
            ? null
            : Capabilities.fromJson(json["capabilities"]),
        extraCapabilities: json["extra_capabilities"] == null
            ? null
            : ExtraCapabilities.fromJson(json["extra_capabilities"]),
        avatarUrls: Map.from(json["avatar_urls"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "url": url,
        "description": description,
        "link": link,
        "locale": locale,
        "nickname": nickname,
        "slug": slug,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "registered_date": registeredDate?.toIso8601String(),
        "capabilities": capabilities?.toJson(),
        "extra_capabilities": extraCapabilities?.toJson(),
        "avatar_urls": Map.from(avatarUrls!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "meta": meta?.toJson(),
        "_links": links?.toJson(),
      };
}

class Capabilities {
  bool? read;
  bool? level0;
  bool? subscriber;

  Capabilities({
    this.read,
    this.level0,
    this.subscriber,
  });

  factory Capabilities.fromJson(Map<String, dynamic> json) => Capabilities(
        read: json["read"],
        level0: json["level_0"],
        subscriber: json["subscriber"],
      );

  Map<String, dynamic> toJson() => {
        "read": read,
        "level_0": level0,
        "subscriber": subscriber,
      };
}

class ExtraCapabilities {
  bool? subscriber;

  ExtraCapabilities({
    this.subscriber,
  });

  factory ExtraCapabilities.fromJson(Map<String, dynamic> json) =>
      ExtraCapabilities(
        subscriber: json["subscriber"],
      );

  Map<String, dynamic> toJson() => {
        "subscriber": subscriber,
      };
}

class Links {
  List<Collection>? self;
  List<Collection>? collection;

  Links({
    this.self,
    this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? []
            : List<Collection>.from(
                json["self"]!.map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null
            ? []
            : List<Collection>.from(
                json["collection"]!.map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? []
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? []
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
      };
}

class Collection {
  String? href;

  Collection({
    this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Meta {
  List<dynamic>? persistedPreferences;

  Meta({
    this.persistedPreferences,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        persistedPreferences: json["persisted_preferences"] == null
            ? []
            : List<dynamic>.from(json["persisted_preferences"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "persisted_preferences": persistedPreferences == null
            ? []
            : List<dynamic>.from(persistedPreferences!.map((x) => x)),
      };
}
