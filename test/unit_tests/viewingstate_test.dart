import 'package:flutter_test/flutter_test.dart';
import 'package:toodoo/models/AppModel.dart';
import 'package:toodoo/models/Task.dart';

void main() {
  group('Viewing State:', () {
    test('Initial viewing state should be All', () {
      expect(AppModel().viewingState, ViewingState.All);
    });

    test('viewing state should be changed to All', () {
      final appModel = AppModel();

      appModel.viewAllTasks();

      expect(appModel.viewingState, ViewingState.All);
    });

    test('viewing state should be changed to Done', () {
      final appModel = AppModel();

      appModel.viewDoneTasks();

      expect(appModel.viewingState, ViewingState.Done);
    });

    test('viewing state should be changed to Not Done', () {
      final appModel = AppModel();

      appModel.viewNotDoneTasks();

      expect(appModel.viewingState, ViewingState.NotDone);
    });
  });
}
