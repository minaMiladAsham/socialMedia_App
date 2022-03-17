class CreatePost {
  String? name;
  String? profileImage;
  String? uId;
  String? text;
  String? postImage;
  String? dateTime;

  CreatePost(
      {
        required this.name,
        required this.profileImage,
        required this.uId,
        required this.text,
        required this.postImage,
        required this.dateTime,
      });

    CreatePost.fromJson(Map<String , dynamic>? json){
    uId = json!['uId'];
    name = json['name'];
    text = json['text'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'dateTime' : dateTime,
      'uId' : uId,
      'text' : text,
      'postImage' : postImage,
      'profileImage' : profileImage,
    };
  }
}
