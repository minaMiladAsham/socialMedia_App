class saveDataInFirebaseModel {
  String? name;
  String? uId;
  String? phone;
  String? email;
  String? coverImage;
  String? profileImage;
  String? bio;

  saveDataInFirebaseModel(
      {
        required this.phone,
      required this.email,
      required this.name,
      required this.uId,
      required this.bio,
        required this.coverImage,
        required this.profileImage,
      });

  saveDataInFirebaseModel.fromJson(Map<String , dynamic>? json){
    uId = json!['uId'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    bio = json['bio'];
    coverImage = json['coverImage'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'uId' : uId,
      'bio' : bio,
      'coverImage' : coverImage,
      'profileImage' : profileImage,
    };
  }
}
