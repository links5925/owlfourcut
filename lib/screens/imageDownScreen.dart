import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:owlfourcut/viewModels/frameColorVm.dart';
import 'package:owlfourcut/viewModels/getImageScreensVM.dart';
import 'package:owlfourcut/viewModels/imageSelectVM.dart';
import 'package:owlfourcut/widgets/mainFrame.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class Imagedownscreen extends ConsumerStatefulWidget {
  const Imagedownscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImagedownscreenState();
}

class _ImagedownscreenState extends ConsumerState<Imagedownscreen> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    bool po = true;
    GlobalKey key = GlobalKey();
    Future<void> saveScreenshot(BuildContext context) async {
      if (po) {
        setState(() {
          po = false;
        });
        // 권한 요청
        var status = await Permission.storage.request();
        if (status.isGranted) {
          debugPrint('권한 승인');
          // 화면 캡처
          await screenshotController.capture().then((Uint8List? image) async {
            debugPrint('캡쳐 완');

            if (image != null) {
              // 캡처한 이미지 저장
              await ImageGallerySaver.saveImage(image);
              debugPrint('사진 저장');

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('사진이 저장됐습니다!')),
              );
              po = true;
            } else {
              debugPrint('사진 null');
            }
          }).catchError((onError) {
            debugPrint(onError);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('접근 권한이 없습니다')),
          );
        }
      }
      po = true;
    }

    Future<void> _shareInsta() async {
      try {
        RenderRepaintBoundary? boundary =
            key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
        if (boundary != null) {
          final image = await boundary.toImage(pixelRatio: 2);
          final byteData = await image.toByteData(format: ImageByteFormat.png);
          Uint8List pngBytes = byteData!.buffer.asUint8List();

          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/shared_image.png').create();
          await file.writeAsBytes(pngBytes);

          SocialShare.shareInstagramStory(
            imagePath: file.path,
            backgroundTopColor: "#ffffff",
            backgroundBottomColor: "#000000",
            appId: 'com.yeah.owlfourcut',
          );
          print('object');
        } else {
          debugPrint("Boundary is null");
        }
      } catch (e) {
        debugPrint('error: $e');
      }
    }

    return Stack(
      children: [
        Container(
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height),
        Scaffold(
          appBar: AppBar(
            title: const Text('사진 다운로드'),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  ref.read(frameColorProvider.notifier).state =
                      const Color(0xffffffff);
                  ref.read(camearImagesListProvider.notifier).state = [];
                  ref.read(imageSelectProvider.notifier).initialize();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('처음으로', style: TextStyle(fontSize: 16)),
              ),
              const Gap(30),
            ],
          ),
          body: SafeArea(
              child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(40),
                    GestureDetector(
                      onTap: () {
                        saveScreenshot(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('다운로드',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Icon(Icons.download_sharp)
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () async {
                        _shareInsta();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/insta.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(20),
                Screenshot(
                    controller: screenshotController,
                    child: RepaintBoundary(key: key, child: const Mainframe3()))
              ],
            ),
          )),
        )
      ],
    );
  }
}
