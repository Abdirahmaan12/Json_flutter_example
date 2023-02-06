class Photos {
  int? albumbId;
  int? id;
  String? title;
  String? url;
  String? thumnailUrl;

  Photos({this.id, this.albumbId, this.title, this.thumnailUrl, this.url});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
        albumbId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumnailUrl: json['thumbnailUrl']);
  }
}
