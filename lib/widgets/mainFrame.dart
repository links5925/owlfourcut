import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/viewModels/frameColorVm.dart';
import 'package:owlfourcut/viewModels/imageSelectVM.dart';

class Mainframe1 extends ConsumerStatefulWidget {
  const Mainframe1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Mainframe1State();
}

class _Mainframe1State extends ConsumerState<Mainframe1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height - 200,
      width: (MediaQuery.sizeOf(context).width - 60) / 2,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: (EdgeInsets.only(
                    bottom: ((MediaQuery.sizeOf(context).height - 300) -
                            ((MediaQuery.sizeOf(context).width - 100) * 1.5)) /
                        4)),
                child: GestureDetector(
                  onTap: () {
                    ref.read(imageSelectProvider.notifier).removeImage(index);
                  },
                  child: Container(
                    width: (MediaQuery.sizeOf(context).width - 100) / 2,
                    height:
                        ((MediaQuery.sizeOf(context).width - 100) / 2) / 4 * 3,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        image: ref.watch(imageSelectProvider).length > index
                            ? DecorationImage(
                                image: FileImage(
                                    ref.watch(imageSelectProvider)[index]),
                                fit: BoxFit.cover)
                            : null),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          const Text('Made by Yeah', style: TextStyle(fontSize: 10)),
          const Gap(10)
        ],
      ),
    );
  }
}

class Mainframe2 extends ConsumerStatefulWidget {
  const Mainframe2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Mainframe2State();
}

class _Mainframe2State extends ConsumerState<Mainframe2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height - 200,
      width: (MediaQuery.sizeOf(context).width - 60) / 2,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: ref.watch(frameColorProvider),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: (EdgeInsets.only(
                    bottom: ((MediaQuery.sizeOf(context).height - 300) -
                            ((MediaQuery.sizeOf(context).width - 100) * 1.5)) /
                        4)),
                child: Container(
                  width: (MediaQuery.sizeOf(context).width - 100) / 2,
                  height:
                      ((MediaQuery.sizeOf(context).width - 100) / 2) / 4 * 3,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: ref.watch(imageSelectProvider).length > index
                          ? DecorationImage(
                              image: FileImage(
                                  ref.watch(imageSelectProvider)[index]),
                              fit: BoxFit.cover)
                          : null),
                ),
              );
            },
          ),
          const Spacer(),
          const Text('Made by Yeah', style: TextStyle(fontSize: 10)),
          const Gap(10)
        ],
      ),
    );
  }
}

class Mainframe3 extends ConsumerStatefulWidget {
  const Mainframe3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Mainframe3State();
}

class _Mainframe3State extends ConsumerState<Mainframe3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.sizeOf(context).height - 200) * 0.75,
      width: ((MediaQuery.sizeOf(context).width - 60) / 2) * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      decoration: BoxDecoration(
          color: ref.watch(frameColorProvider),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(7.5),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: (EdgeInsets.only(
                        bottom: ((MediaQuery.sizeOf(context).height - 300) -
                                ((MediaQuery.sizeOf(context).width - 100) *
                                    1.5)) *
                            3 /
                            4) /
                    4),
                child: Container(
                  width: (MediaQuery.sizeOf(context).width - 100) / 8 * 3,
                  height:
                      ((MediaQuery.sizeOf(context).width - 100) / 2) / 16 * 9,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: ref.watch(imageSelectProvider).length > index
                          ? DecorationImage(
                              image: FileImage(
                                  ref.watch(imageSelectProvider)[index]),
                              fit: BoxFit.cover)
                          : null),
                ),
              );
            },
          ),
          const Spacer(),
          const Text('Made by Yeah', style: TextStyle(fontSize: 8)),
          const Gap(7.5)
        ],
      ),
    );
  }
}
