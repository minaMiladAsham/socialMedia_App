class saveDataInFirebaseModel {
  String? name;
  String? uId;
  String? phone;
  String? email;
  late bool isVerified;

  saveDataInFirebaseModel(
      {required this.phone,
      required this.email,
      required this.name,
      required this.uId,
      required this.isVerified});

  saveDataInFirebaseModel.fromJson(Map<String , dynamic>? json){
    uId = json!['uId'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'uId' : uId,
      'isVerified' : isVerified,
    };
  }
}
