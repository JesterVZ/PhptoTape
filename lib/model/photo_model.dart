class PhotoModel{
  String? id;
  String? owner;
  String? secret;
  String? server;
  int? farm;
  String? title;
  int? ispublic;
  int? isfriend;
  int? isfamily;

  PhotoModel({
    required this.id,
    required this.owner,
    required this.secret,
    required this.server,
    required this.farm,
    required this.title,
    required this.isfamily,
    required this.isfriend,
    required this.ispublic
  });

  factory PhotoModel.fromMap(Map<dynamic, dynamic> map){
    return PhotoModel(
      id: map['id'],
      owner: map['owner'],
      secret: map['secret'],
      server: map['server'],
      farm: map['farm'],
      title: map['title'],
      ispublic: map['ispublic'],
      isfriend: map['isfriend'],
      isfamily: map['isfamily']
    );
  }
}