import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/models/chatModel.dart';
import 'package:owlfourcut/theme/colors.dart';
import 'package:owlfourcut/viewModels/myTextVM.dart';

class Guestbook extends ConsumerStatefulWidget {
  const Guestbook({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuestbookState();
}

class _GuestbookState extends ConsumerState<Guestbook> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        try {
          final snapshot = await _dbRef.child('chat').get();
          if (snapshot.exists) {
            final data = snapshot.value as Map<dynamic, dynamic>;
            List<Chat> cList = [];
            data.forEach((key, value) {
              cList.add(Chat(text: value['text'], time: value['time']));
            });
            ref.read(allTextProvider.notifier).setValue(cList);
          }
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
                          ...ref.watch(allTextProvider).map(
                            (e) {
                              return _container(e);
                            },
                          ),
                          ...List.generate(
                            ref.watch(mytextProvider).length,
                            (index) {
                              return _container(
                                  ref.watch(mytextProvider)[index]);
                            },
                          ),
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
                              Chat chat = Chat.now(controller.text);
                              try {
                                await _dbRef.child('chat').push().set(
                                    {'text': chat.text, 'time': chat.time});
                              } catch (error) {
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
              color: AppColors.colors6_3.withOpacity(0.6),
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
        )
      ],
    );
  }
}
