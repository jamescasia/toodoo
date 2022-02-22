import 'package:flutter_test/flutter_test.dart';
import 'package:toodoo/models/AppModel.dart';
import 'package:toodoo/models/Task.dart';

void main() {
  group('Tasks being viewed:', () {
    test('Initial tasks being viewed should be equal to tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      expect(appModel.tasksBeingViewed, tasks);
    });

    test('Tasks being viewed should be all tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      appModel.viewAllTasks();

      expect(appModel.tasksBeingViewed, tasks);
    });

    test('Tasks being viewed should be done tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      appModel.viewDoneTasks();

      for (Task task in appModel.tasksBeingViewed) {
        expect(task.done, true);
      }
    });

    test('Tasks being viewed should be not done tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      appModel.viewNotDoneTasks();

      for (Task task in appModel.tasksBeingViewed) {
        expect(task.done, false);
      }
    });
  });
}
