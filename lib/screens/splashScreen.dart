import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/screens/getImagesScreen.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
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
            body: SafeArea(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '부엉네컷',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.brown),
                ),
                const Gap(30),
                Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            image: AssetImage('assets/logo.png')))),
                const Gap(30),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Getimagesscreen()));
                    },
                    child: const Text('시작하기',
                        style: TextStyle(color: Colors.black, fontSize: 20))),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
