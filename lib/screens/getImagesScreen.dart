import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/screens/selectImageScreen.dart';
import 'package:owlfourcut/utils/getImage.dart';
import 'package:owlfourcut/viewModels/getImageScreensVM.dart';

class Getimagesscreen extends ConsumerStatefulWidget {
  const Getimagesscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GetimagesscreenState();
}

class _GetimagesscreenState extends ConsumerState<Getimagesscreen> {
  CameraController? _controller;
  @override
  void initState() {
    // _initializeCamera();
    super.initState();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    _controller = CameraController(frontCamera, ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg);
    await _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

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
            centerTitle: true,
            title: const Text('사진 촬영'),
            actions: [
              GestureDetector(
                  onTap: () {
                    if (ref.watch(camearImagesListProvider).length >= 4) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Selectimagescreen(),
                          ));
                    }
                  },
                  child: const Text('다음', style: TextStyle(fontSize: 16))),
              const Gap(30)
            ],
          ),
          body: _widget2(),
        ),
      ],
    );
  }

  Widget _widget1() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height - 300,
          child: _controller == null ? null : CameraPreview(_controller!),
        ),
        const Gap(30),
        GestureDetector(
            onTap: () async {
              print(ref.watch(camearImagesListProvider).toString());
              try {
                if (!_controller!.value.isInitialized) return;

                XFile? image = await _controller!.takePicture();

                ref.read(camearImagesListProvider.notifier).state = [
                  ...ref.watch(camearImagesListProvider),
                  (File(image.path))
                ];
                print(ref.watch(camearImagesListProvider));
              } catch (e) {
                print("Error capturing image: $e");
              }
            },
            child: const Text('Click!'))
      ],
    );
  }

  Widget _widget2() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          const Gap(60),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 40,
            child: Column(
              children: [
                Row(
                  children: [_container(0), const Gap(20), _container(1)],
                ),
                const Gap(20),
                Row(
                  children: [_container(2), const Gap(20), _container(3)],
                ),
                const Gap(20),
                Row(
                  children: [_container(4), const Gap(20), _container(5)],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _container(int idx) {
    return GestureDetector(
      child: ref.watch(camearImagesListProvider).length > idx
          ? Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: (MediaQuery.sizeOf(context).width - 60) / 2,
                  height: ((MediaQuery.sizeOf(context).width - 60) / 2) / 4 * 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(
                              ref.watch(camearImagesListProvider)[idx]),
                          fit: BoxFit.cover)),
                ),
                Transform.translate(
                  offset: const Offset(8, -8),
                  child: InkWell(
                    onTap: () {
                      List<File> list = [];
                      for (File file in ref.watch(camearImagesListProvider)) {
                        if (file != ref.watch(camearImagesListProvider)[idx]) {
                          list.add(file);
                        }
                      }
                      ref.read(camearImagesListProvider.notifier).state = list;
                    },
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(90)),
                      child: const Icon(Icons.delete, size: 14),
                    ),
                  ),
                )
              ],
            )
          : GestureDetector(
              onTap: () async {
                List<File> iamges =
                    await getImages(ref.watch(camearImagesListProvider).length);
                ref.watch(camearImagesListProvider.notifier).state = [
                  ...ref.watch(camearImagesListProvider),
                  ...iamges
                ];
              },
              child: Container(
                width: (MediaQuery.sizeOf(context).width - 60) / 2,
                height: ((MediaQuery.sizeOf(context).width - 60) / 2) / 4 * 3,
                color: Colors.grey,
                child: Icon(Icons.camera_alt_outlined,
                    size:
                        max((MediaQuery.sizeOf(context).width) / 2 - 150, 30)),
              ),
            ),
    );
  }
}
