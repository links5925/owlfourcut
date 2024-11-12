import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final camearImagesListProvider = StateProvider<List<File>>((ref) {
  return [];
});
