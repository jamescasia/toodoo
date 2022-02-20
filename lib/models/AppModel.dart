import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/Task.dart';

class AppModel extends Model {
  List<Task> tasks = [];

  List<Task> tasksBeingViewed = [];

  ViewingState viewingState = ViewingState.All;
  AppState appState = AppState.ViewingTasks;
  Task? taskBeingDeleted;
  Task? taskBeingMarkedDone;

  AppModel() {
    this.setTasks([
      Task("1", "Walk the dogs", "walk the dogs and do 5 laps", true, false),
      Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", false,
          false),
      Task("3", "Study for Calculus exam", "walk the dogs and do 5 laps", true,
          false),
      Task("4", "Go sleep", "Get laundry at laundryhouse at 3PM", false, false),
    ]);
    this.tasksBeingViewed = List.from(this.tasks);
  }

  // Switch Viewing State
  void viewAllTasks() {
    viewingState = ViewingState.All;
    tasksBeingViewed = List.from(tasks);
    notifyListeners();
  }

  void viewDoneTasks() {
    viewingState = ViewingState.Done;
    tasksBeingViewed = new List.from(tasks.where((t) => t.done).toList());

    notifyListeners();
  }

  void viewNotDoneTasks() {
    this.viewingState = ViewingState.NotDone;
    tasksBeingViewed = new List.from(tasks.where((t) => !t.done).toList());

    notifyListeners();
  }

  //  Delete task
  void deleteTask(task) {
    this.tasks.retainWhere((t) => t.id != task.id);
    this.tasksBeingViewed.retainWhere((t) => t.id != task.id);
    notifyListeners();
  }

// Update task
  void updateTask(task) {
    this.tasks = this
        .tasks
        .map((t) {
          if (t.id == task.id) {
            return task;
          }
          return t;
        })
        .toList()
        .cast();

    this.tasksBeingViewed = this
        .tasksBeingViewed
        .map((t) {
          if (t.id == task.id) {
            return task;
          }
          return t;
        })
        .toList()
        .cast();
    notifyListeners();
  }

// Mark task as done
  void markTaskAsDone() {
    taskBeingMarkedDone!.done = true;
    updateTask(this.taskBeingMarkedDone);
  }

// Tasks setter
  void setTasks(tasks) {
    this.tasks = tasks;
    this.tasksBeingViewed = this.tasks;
  }

  void addTask(task) {
    this.tasks.add(task);
    if (this.viewingState != ViewingState.NotDone) {
      this.tasksBeingViewed.add(task);
    }
    notifyListeners();
  }

  // Show add task modal
  void showAddTaskModal() {
    this.appState = AppState.AddingTask;
    notifyListeners();
  }

  void hideAddTaskModal() {
    this.appState = AppState.ViewingTasks;
    notifyListeners();
  }

  // Show delete task modal
  void showDeleteTaskModal(Task task) {
    this.appState = AppState.DeletingTask;
    this.taskBeingDeleted = task;
    notifyListeners();
  }

  void hideDeleteTaskModal() {
    this.appState = AppState.ViewingTasks;
    notifyListeners();
  }

  // show finish task modal
  void showMarkDoneTaskModal(Task task) {
    this.appState = AppState.MarkingDoneTask;
    this.taskBeingMarkedDone = task;
    notifyListeners();
  }

  void hideMarkDoneTaskModal() {
    this.appState = AppState.ViewingTasks;
    notifyListeners();
  }
}

enum ViewingState { All, Done, NotDone }

enum AppState {
  AddingTask,
  DeletingTask,
  MarkingDoneTask,
  ViewingTasks,
}
