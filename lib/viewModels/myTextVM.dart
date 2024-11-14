import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:owlfourcut/models/chatModel.dart';

class AllTextListVM extends StateNotifier<List<Chat>> {
  AllTextListVM() : super([]);

  Future setValue() async {
    state = [];
  }

  initialize() {
    state = [];
  }
}

final allTextProvider = StateNotifierProvider<AllTextListVM, List<Chat>>((ref) {
  return AllTextListVM();
});

final mytextProvider = StateProvider<List<Chat>>((ref) {
  return [];
});
