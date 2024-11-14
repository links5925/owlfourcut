import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Guestbook extends ConsumerStatefulWidget {
  const Guestbook({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuestbookState();
}

class _GuestbookState extends ConsumerState<Guestbook> {
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
          appBar: AppBar(title: const Text('방명록'), centerTitle: true),
          body: SafeArea(
              child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
          )),
        )
      ],
    );
  }
}
