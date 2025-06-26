class Messages {
  final String messages;
   final String id;
  Messages(this.messages,this.id);

  factory Messages.fromJson(jsonData) {
    return Messages(jsonData['messages'] ,jsonData['id'] );
  }
}
