class ChatModel {
  String? dateTime;
  String? receiverId;
  String? senderId;
  String? text;

  ChatModel(
      {
        required this.dateTime,
        required this.receiverId,
        required this.senderId,
        required this.text,
      });

  ChatModel.fromJson(Map<String , dynamic>? json){
    dateTime = json!['dateTime'];
    receiverId = json['receiverId'];
    text = json['text'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> toMap(){
    return {
      'receiverId' : receiverId,
      'dateTime' : dateTime,
      'senderId' : senderId,
      'text' : text,
    };
  }
}
