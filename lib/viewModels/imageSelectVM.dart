import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageSelect extends StateNotifier<List<File>> {
  ImageSelect() : super([]);

  addImage(File file) {
    if (state.length < 4) {
      state = [...state, file];
    }
  }

  removeImage(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
  }

  initialize() {
    state = [];
  }
}

final imageSelectProvider =
    StateNotifierProvider<ImageSelect, List<File>>((ref) {
  return ImageSelect();
});
