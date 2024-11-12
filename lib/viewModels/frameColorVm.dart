import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final frameColorProvider = StateProvider<Color>((ref) {
  return Color(0xffffffff);
});
