import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/screens/getImagesScreen.dart';
import 'package:owlfourcut/viewModels/frameSelectVM.dart';

class Frameselectscreen extends ConsumerStatefulWidget {
  const Frameselectscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FrameselectscreenState();
}

class _FrameselectscreenState extends ConsumerState<Frameselectscreen> {
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
              title: const Text('프레임 선택'),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Getimagesscreen(),
                        ));
                  },
                  child: const Text('다음', style: TextStyle(fontSize: 16)),
                ),
                const Gap(30)
              ],
            ),
          body: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (ref.watch(frameSelectProvider) == 1) {
                      ref.read(frameSelectProvider.notifier).state = 0;
                    } else {
                      ref.read(frameSelectProvider.notifier).state = 1;
                    }
                  },
                  child: Container(
                    width: (MediaQuery.sizeOf(context).width - 100) / 2,
                    height: (MediaQuery.sizeOf(context).width - 100) / 2,
                    decoration: BoxDecoration(
                        color: ref.watch(frameSelectProvider) == 1
                            ? Colors.grey
                            : Colors.white),
                  ),
                ),
                const Gap(50),
                GestureDetector(
                  onTap: () {
                    if (ref.watch(frameSelectProvider) == 2) {
                      ref.read(frameSelectProvider.notifier).state = 0;
                    } else {
                      ref.read(frameSelectProvider.notifier).state = 2;
                    }
                  },
                  child: Container(
                    width: (MediaQuery.sizeOf(context).width - 100) / 2,
                    height: (MediaQuery.sizeOf(context).width - 100) / 2,
                    decoration: BoxDecoration(
                        color: ref.watch(frameSelectProvider) == 2
                            ? Colors.grey
                            : Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
