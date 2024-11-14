class Chat {
  String text;
  String time;

  Chat({required this.text, required this.time});

  factory Chat.fromJson(Map<String, String> json) {
    return Chat(text: json['text'] ?? '', time: json['time'] ?? 's');
  }
}
