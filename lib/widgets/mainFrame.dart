import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/theme/colors.dart';
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
    double frameWidth = ((MediaQuery.sizeOf(context).width - 60) / 2);
    return Container(
      height: frameWidth * 3 + 7,
      width: frameWidth,
      padding: EdgeInsets.symmetric(horizontal: frameWidth) * 0.108,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(frameWidth * 0.41),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: index < 3
                    ? (EdgeInsets.only(bottom: frameWidth * 0.026))
                    : const EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    ref.read(imageSelectProvider.notifier).removeImage(index);
                  },
                  child: Container(
                    width: frameWidth * 0.783,
                    height: frameWidth * 0.588,
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
    double frameWidth = ((MediaQuery.sizeOf(context).width - 60) / 2);
    return Container(
      height: frameWidth * 3 + 7,
      width: frameWidth,
      padding: EdgeInsets.symmetric(horizontal: frameWidth) * 0.108,
      decoration: BoxDecoration(
          color: ref.watch(frameColorProvider),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(frameWidth * 0.41),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: index < 3
                    ? (EdgeInsets.only(bottom: frameWidth * 0.026))
                    : const EdgeInsets.all(0),
                child: Container(
                  width: frameWidth * 0.783,
                  height: frameWidth * 0.588,
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
          // const Text('Made by Yeah', style: TextStyle(fontSize: 10)),
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
    double frameWidth = ((MediaQuery.sizeOf(context).width - 60) / 2);
    return Container(
      height: frameWidth * 3 + 7,
      width: frameWidth,
      padding: EdgeInsets.symmetric(horizontal: frameWidth) * 0.108,
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
                padding: index < 3
                    ? (EdgeInsets.only(bottom: frameWidth * 0.026))
                    : const EdgeInsets.all(0),
                child: Container(
                  width: frameWidth * 0.783,
                  height: frameWidth * 0.588,
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
        ],
      ),
    );
  }
}

class CustomFrame1 extends ConsumerStatefulWidget {
  const CustomFrame1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomFrame1State();
}

class _CustomFrame1State extends ConsumerState<CustomFrame1> {
  @override
  Widget build(BuildContext context) {
    double frameWidth = ((MediaQuery.sizeOf(context).width - 60) / 2);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: frameWidth * 3 + 7,
          width: frameWidth,
          padding: EdgeInsets.symmetric(horizontal: frameWidth) * 0.108,
          decoration: BoxDecoration(
              color: AppColors.frame1, border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(frameWidth * 0.41),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: index < 3
                        ? (EdgeInsets.only(bottom: frameWidth * 0.026))
                        : const EdgeInsets.all(0),
                    child: Container(
                      width: frameWidth * 0.783,
                      height: frameWidth * 0.588,
                      decoration: BoxDecoration(
                          color: AppColors.frame1,
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
            ],
          ),
        ),
        Container(
          height: (MediaQuery.sizeOf(context).width - 60) / 2 * 3,
          width: (MediaQuery.sizeOf(context).width - 60) / 2,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/frame1.png'), fit: BoxFit.contain)),
        ),
      ],
    );
  }
}

class CustomFrame2 extends ConsumerStatefulWidget {
  const CustomFrame2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomFrame2State();
}

class _CustomFrame2State extends ConsumerState<CustomFrame2> {
  @override
  Widget build(BuildContext context) {
    double frameWidth = ((MediaQuery.sizeOf(context).width - 60) / 2);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: frameWidth * 3 + 7,
          width: frameWidth,
          padding: EdgeInsets.symmetric(horizontal: frameWidth) * 0.108,
          decoration: BoxDecoration(
              color: AppColors.frame2, border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(frameWidth * 0.15),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: index < 3
                        ? (EdgeInsets.only(bottom: frameWidth * 0.026))
                        : const EdgeInsets.all(0),
                    child: Container(
                      width: frameWidth * 0.783,
                      height: frameWidth * 0.588,
                      decoration: BoxDecoration(
                          color: AppColors.frame2,
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
            ],
          ),
        ),
        Container(
          height: (MediaQuery.sizeOf(context).width - 60) / 2 * 3,
          width: (MediaQuery.sizeOf(context).width - 60) / 2,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/frame2.png'), fit: BoxFit.contain)),
        ),
      ],
    );
  }
}
