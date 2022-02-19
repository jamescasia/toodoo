import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/Task.dart';

class AppModel extends Model {
  List<Task> tasks = [];

  List<Task> tasksBeingViewed = [];

  ViewingState viewingState = ViewingState.All;
  AppState appState = AppState.ViewingTasks;

  AppModel() {
    tasks = [
      Task(1, "Walk the dogs", "walk the dogs in ayala and do 5 laps", false,
          true),
      Task(
          2,
          "Follow your tempo",
          "Follow follow follow follow your tempo your follow follow",
          true,
          false),
      Task(3, "Get laundry", "Get laundry at laundryhouse at 3PM", true, true),
      Task(
          4,
          "Study for Calculus exam",
          "Study for calculus exam: Limits, Infinite Series, Limits at Infinity",
          false,
          true),
      Task(1, "Walk the dogs", "walk the dogs in ayala and do 5 laps", false,
          false),
      Task(
          2,
          "Follow your tempo",
          "Follow follow follow follow your tempo your follow follow",
          true,
          true),
      Task(3, "Get laundry", "Get laundry at laundryhouse at 3PM", true, false),
      Task(
          4,
          "Study for Calculus exam",
          "Study for calculus exam: Limits, Infinite Series, Limits at Infinity",
          false,
          true),
      Task(1, "Walk the dogs", "walk the dogs in ayala and do 5 laps", false,
          true),
      Task(
          2,
          "Follow your tempo",
          "Follow follow follow follow your tempo your follow follow",
          true,
          false),
      Task(3, "Get laundry", "Get laundry at laundryhouse at 3PM", true, true),
    ];
    this.tasksBeingViewed = tasks;
  }

  // Switch Viewing State
  void viewAllTasks() {
    this.viewingState = ViewingState.All;
    this.tasksBeingViewed = tasks;
    notifyListeners();
  }

  void viewDoneTasks() {
    this.viewingState = ViewingState.Done;
    this.tasksBeingViewed = this.tasks.where((e) => e.done).toList();
    notifyListeners();
  }

  void viewNotDoneTasks() {
    this.viewingState = ViewingState.NotDone;
    this.tasksBeingViewed = this.tasks.where((e) => !e.done).toList();
    notifyListeners();
  }
}

enum ViewingState { All, Done, NotDone }

enum AppState {
  AddingTask,
  DeletingTask,
  MarkingDoneTask,
  MarkingUndoneTask,
  ViewingTasks,
}
