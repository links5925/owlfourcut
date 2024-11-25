import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:owlfourcut/models/chatModel.dart';
import 'package:owlfourcut/theme/colors.dart';
import 'package:owlfourcut/viewModels/myTextVM.dart';
import 'package:http/http.dart' as http;

class Guestbook extends ConsumerStatefulWidget {
  const Guestbook({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuestbookState();
}

class _GuestbookState extends ConsumerState<Guestbook> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  TextEditingController controller = TextEditingController();
  String _changer(String value) {
    DateTime dateTime = DateTime.parse(value);

    String formattedDate = DateFormat("MM/dd HH:mm").format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        try {
          Uri url = Uri.parse('http://13.209.240.117:8080/guestbook/get');
          final response = await http.get(url);
          if (response.statusCode == 200) {
            Map<String, dynamic> responseData =
                json.decode(utf8.decode(response.bodyBytes));
            List datas = responseData['data']['guestBookList'];
            ref.read(allTextProvider.notifier).setValue(datas.map((v) {
                  return Chat(
                      text: v['content'] ?? '',
                      time: _changer(v['createdAt'] ?? ''));
                }).toList());
          } else {}
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('방명록 업로드에 실패했습니다')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
        ),
        Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          appBar: AppBar(
            title: const Text('방명록'),
            centerTitle: true,
            backgroundColor: Colors.grey.withOpacity(0.1),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          body: SafeArea(
              child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            ref.watch(mytextProvider).length,
                            (index) {
                              return _container(ref.watch(mytextProvider)[
                                  ref.watch(mytextProvider).length -
                                      index -
                                      1]);
                            },
                          ),
                          ...ref.watch(allTextProvider).map(
                            (e) {
                              return _container(e);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // const Gap(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.1),
                  ),
                  height: 60,
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        width: MediaQuery.sizeOf(context).width - 80,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          controller: controller,
                          maxLength: 500,
                          maxLines: 10,
                          autofocus: false,
                          showCursor: true,
                          cursorColor: AppColors.colors6_3,
                          cursorHeight: 20,
                          decoration: const InputDecoration(
                              counterText: '',
                              counterStyle:
                                  TextStyle(height: double.minPositive),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      const Gap(15),
                      GestureDetector(
                          onTap: () async {
                            ref.read(mytextProvider.notifier).state = [
                              ...ref.watch(mytextProvider),
                              Chat.now(controller.text)
                            ];
                            if (controller.text != '') {
                              try {
                                final a = await http.post(
                                    Uri.parse(
                                        'http://13.209.240.117:8080/guestbook/write'),
                                    body: jsonEncode({"content": controller.text}),
                                    headers: {
                                      'Content-Type': 'application/json'
                                    });
                                print(a.statusCode);
                              } catch (error) {
                                print(error);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('방명록 작성에 실패했습니다')),
                                );
                              }
                            }
                            controller.clear();
                          },
                          child: Icon(Icons.send,
                              size: 20, color: Colors.blue[300]))
                    ],
                  ),
                )
              ],
            ),
          )),
        )
      ],
    );
  }

  Widget _container(Chat chat) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.6),
          decoration: BoxDecoration(
              color: AppColors.chat.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Text(chat.text),
        ),
        const Gap(6),
        Text(
          chat.time,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
        const Gap(5),
        InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('신고'),
                    content: const Text('이 댓글을 신고하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          '취소',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          '확인',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.notification_important_outlined,
              size: 13,
              color: Colors.grey,
            ))
      ],
    );
  }
}
