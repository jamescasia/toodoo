import 'package:flutter_test/flutter_test.dart';
import 'package:toodoo/models/AppModel.dart';
import 'package:toodoo/models/Task.dart';

void main() {
  group('Tasks:', () {
    test('Initial tasks should be equal to tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      expect(appModel.tasks, tasks);
    });

    test('Created task should be added to tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      Task task = Task("3", "This is a new task", "new task", false, true);
      appModel.addTask(task);

      expect(appModel.tasks.contains(task), true);
    });

    test('Deleted task should not be in tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);
      Task task = Task(
          "1", "Walk the dogs", "walk the dogs and do 5 laps", false, true);

      appModel.deleteTask(task);

      expect(appModel.tasks.contains(task), false);
    });

    test('Updated task should be updated in tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      Task task = Task(
          "1", "Walk the cats", "walk the dogs and do 5 laps", false, true);

      appModel.updateTask(task);

      expect(appModel.tasks.first, task);
    });

    test('Marked as done task should be marked as done in tasks', () {
      AppModel appModel = AppModel();
      List<Task> tasks = [
        Task("1", "Walk the dogs", "walk the dogs and do 5 laps", false, true),
        Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", true,
            true),
      ];
      appModel.setTasks(tasks);

      appModel.taskBeingMarkedDone = tasks.first;
      appModel.markTaskAsDone();

      expect(appModel.tasks.first.done, true);
    });
  });
}
