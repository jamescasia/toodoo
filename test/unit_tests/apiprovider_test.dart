import 'package:flutter_test/flutter_test.dart';
import 'package:async/async.dart';
import 'package:toodoo/models/Task.dart';
import 'package:toodoo/services/ApiProvider.dart';

// Helper function for comparing tasks
bool equivalentTasks(Task task1, Task task2) {
  return task1.title == task2.title &&
      task1.id == task2.id &&
      task1.description == task2.description &&
      task1.done == task2.done &&
      task1.expanded == task2.expanded;
}

// Helper function for checking if task is in array
bool containsTask(List<Task> tasks, task) {
  bool hasTask = false;

  for (int i = 0; i < tasks.length; i++) {
    if (equivalentTasks(tasks[i], task)) {
      hasTask = true;

      break;
    }
  }
  return hasTask;
}

void main() {
  group('Api Provider:', () {
    test('Fetched Tasks should reflect in tasks', () async {
      List<Task> tasks = await ApiProvider().fetchTasks();

      tasks.forEach((task) {
        expect(task.runtimeType, Task);
      });
    });

    test('Upload task should be in tasks', () async {
      Task test_task =
          Task("10", "Test Task", "This is a test description", false, true);

      // Ensure to delete task first
      await ApiProvider().deleteTask(test_task);

      await ApiProvider().uploadTask(test_task);
      // Wait for a couple more seconds to ensure upload
      await Future.delayed(const Duration(seconds: 3));

      // fetch tasks
      List<Task> tasks = await ApiProvider().fetchTasks();

      expect(containsTask(tasks, test_task), true);
    });

    test('Updated task should reflect in tasks', () async {
      Task test_task = Task("10", "Updated Test Task",
          "This is a test updated description", false, true);

      await ApiProvider().updateTask(test_task);
      // Wait for a couple more seconds to ensure delete
      await Future.delayed(const Duration(seconds: 2));

      List<Task> tasks = await ApiProvider().fetchTasks();
      // new updated task should be in tasks
      expect(containsTask(tasks, test_task), true);
    });
    test('Deleted task should not reflect in tasks', () async {
      Task test_task = Task("10", "Updated Test Task",
          "This is a test updated description", false, true);
      await ApiProvider().deleteTask(test_task);
      // Wait for a couple more seconds to ensure delete
      await Future.delayed(const Duration(seconds: 2));

      List<Task> tasks = await ApiProvider().fetchTasks();

      expect(containsTask(tasks, test_task), false);
    });
  });
}
