class PhotoInfo {
  Title? title;
  Owner? owner;
  String? views;

  PhotoInfo({required this.title, required this.owner, required this.views});

  factory PhotoInfo.fromMap(Map<dynamic, dynamic> map) {
    return PhotoInfo(
        title: map['title'] != null ? Title.fromMap(map) : null,
        owner: map['owner'] != null ? Owner.fromMap(map) : null,
        views: map['views']);
  }
}

class Owner {
  String? nsid;
  String? username;
  String? realname;

  Owner({required this.nsid, required this.username, required this.realname});

  factory Owner.fromMap(Map<dynamic, dynamic> map) {
    return Owner(
        nsid: map['nsid'],
        username: map['username'],
        realname: map['realname']);
  }
}

class Title {
  String? content;
  Title({required this.content});
  factory Title.fromMap(Map<dynamic, dynamic> map) {
    return Title(content: map['_content']);
  }
}
