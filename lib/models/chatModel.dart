class Chat {
  String text;
  String time;

  Chat({required this.text, required this.time});

  factory Chat.fromJson(Map<String, String> json) {
    return Chat(text: json['text'] ?? '', time: json['time'] ?? '');
  }

  factory Chat.now(String text) {
    DateTime now = DateTime.now();

    String time =
        '${now.month}/${now.day} ${(now.hour < 10) ? ('0${now.hour}') : now.hour}:${(now.minute < 10) ? ('0${now.minute}') : now.minute}';

    return Chat(text: text, time: time);
  }

  // factory Chat.now(String text)
}
