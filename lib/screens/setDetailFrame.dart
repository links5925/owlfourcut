import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/screens/imageDownScreen.dart';
import 'package:owlfourcut/theme/colors.dart';
import 'package:owlfourcut/viewModels/frameColorVm.dart';
import 'package:owlfourcut/widgets/mainFrame.dart';

class SetDetailFrame extends ConsumerStatefulWidget {
  const SetDetailFrame({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetDetailFrameState();
}

class _SetDetailFrameState extends ConsumerState<SetDetailFrame> {
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
            title: const Text('프레임 꾸미기'),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Imagedownscreen(),
                      ));
                },
                child: const Text('다음', style: TextStyle(fontSize: 16)),
              ),
              const Gap(30)
            ],
          ),
          body: Column(
            children: [
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Mainframe2(), const Gap(20), _right()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _right() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2 - 30,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 200,
        child: ListView(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  색상1',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Wrap(
              children: [
                _colorContainer(AppColors.colors1_2),
                _colorContainer(AppColors.colors1_3),
                _colorContainer(AppColors.colors1_4),
                _colorContainer(AppColors.colors1_5)
              ],
            ),
            const Gap(10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  색상2',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Wrap(
              children: [
                _colorContainer(AppColors.colors2_2),
                _colorContainer(AppColors.colors2_3),
                _colorContainer(AppColors.colors2_4),
                _colorContainer(AppColors.colors2_5)
              ],
            ),
            const Gap(10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  색상3',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Wrap(
              children: [
                _colorContainer(AppColors.colors3_2),
                _colorContainer(AppColors.colors3_3),
                _colorContainer(AppColors.colors3_4),
                _colorContainer(AppColors.colors3_5)
              ],
            ),
            const Gap(10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  색상4',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Wrap(
              children: [
                _colorContainer(AppColors.colors4_1),
                _colorContainer(AppColors.colors4_2),
                _colorContainer(AppColors.colors4_3),
                _colorContainer(AppColors.colors4_4)
              ],
            ),
            const Gap(10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  색상5',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Wrap(
              children: [
                _colorContainer(AppColors.colors5_1),
                _colorContainer(AppColors.colors5_2),
                _colorContainer(AppColors.colors5_3),
                _colorContainer(AppColors.colors5_4),
              ],
            ),
            const Gap(10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '  색상6  ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Wrap(
              children: [
                _colorContainer(AppColors.colors6_1),
                _colorContainer(AppColors.colors6_2),
                _colorContainer(AppColors.colors6_3),
                _colorContainer(AppColors.colors6_4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorContainer(Color color) {
    return GestureDetector(
      onTap: () {
        if (ref.watch(frameColorProvider) == color) {
          ref.read(frameColorProvider.notifier).state = const Color(0xffffffff);
        } else {
          ref.read(frameColorProvider.notifier).state = color;
        }
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: color, border: Border.all(color: Colors.black)),
            ),
            ref.watch(frameColorProvider) == color
                ? Container(
                    margin: const EdgeInsets.all(5),
                    width: 40,
                    height: 40,
                    color: Colors.grey.withOpacity(0.9),
                    child: const Icon(Icons.check_circle_outline_outlined,
                        color: Colors.brown),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
