import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/screens/setDetailFrame.dart';
import 'package:owlfourcut/viewModels/getImageScreensVM.dart';
import 'package:owlfourcut/viewModels/imageSelectVM.dart';
import 'package:owlfourcut/widgets/mainFrame.dart';

class Selectimagescreen extends ConsumerStatefulWidget {
  const Selectimagescreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectimagescreenState();
}

class _SelectimagescreenState extends ConsumerState<Selectimagescreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height),
        Scaffold(
          appBar: AppBar(
            title: const Text('사진 선택'),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  if (ref.watch(imageSelectProvider).length == 4) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetDetailFrame(),
                        ));
                  }
                },
                child: const Text('다음', style: TextStyle(fontSize: 16)),
              ),
              const Gap(30)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [const Mainframe1(), const Gap(20), _right()],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _right() {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width / 2) - 30,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: ref.watch(camearImagesListProvider).length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (!ref
                  .watch(imageSelectProvider)
                  .contains(ref.watch(camearImagesListProvider)[index])) {
                ref
                    .read(imageSelectProvider.notifier)
                    .addImage(ref.watch(camearImagesListProvider)[index]);
              } else {
                for (int i = 0; i < ref.watch(imageSelectProvider).length; i++) {
                  if (ref.watch(imageSelectProvider)[i] ==
                      ref.watch(camearImagesListProvider)[index]) {
                    ref.read(imageSelectProvider.notifier).removeImage(i);
                  }
                }
              }
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: (MediaQuery.sizeOf(context).width - 60) / 2,
                  height: ((MediaQuery.sizeOf(context).width - 60) / 2) / 4 * 3,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: FileImage(
                              ref.watch(camearImagesListProvider)[index]),
                          fit: BoxFit.cover)),
                ),
                ref
                        .watch(imageSelectProvider)
                        .contains(ref.watch(camearImagesListProvider)[index])
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: (MediaQuery.sizeOf(context).width - 60) / 2,
                        height: ((MediaQuery.sizeOf(context).width - 60) / 2) /
                            4 *
                            3,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.9)),
                        child: const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.brown,
                          size: 80,
                        ),
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}
