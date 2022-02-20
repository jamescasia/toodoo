import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/Task.dart';

/* 
AppModel stores all the app state. It extends Model, which is used by ScopedModel state management tool.
 */
class AppModel extends Model {
  // initialize
  List<Task> tasks = [];
  List<Task> tasksBeingViewed = [];
  ViewingState viewingState = ViewingState.All;
  AppState appState = AppState.ViewingTasks;
  // Task variables for task being interacted with
  Task? taskBeingDeleted;
  Task? taskBeingMarkedDone;
  Task? taskBeingMarkedUndone;

  AppModel() {
    this.setTasks([
      Task("1", "Walk the dogs", "walk lil Aki and do 5 laps", true, false),
      Task("2", "Get laundry", "Get laundry at laundryhouse at 3PM", false,
          false),
      Task("3", "Study for Calculus exam",
          "Study limits, infinite series, limits at infinity.", true, false),
      Task("4", "Workout", "Workout and burn calories", false, false),
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
// also update the tasks being viewed
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

// Mark task as undone
  void markTaskAsUndone() {
    taskBeingMarkedUndone!.done = false;
    updateTask(this.taskBeingMarkedUndone);
  }

// Tasks setter
  void setTasks(tasks) {
    this.tasks = tasks;
    this.tasksBeingViewed = this.tasks;
  }

// add task to tasks
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

  // Show and hide delete task modal
  void showDeleteTaskModal(Task task) {
    this.appState = AppState.DeletingTask;
    this.taskBeingDeleted = task;
    notifyListeners();
  }

  void hideDeleteTaskModal() {
    this.appState = AppState.ViewingTasks;
    notifyListeners();
  }

  // show and hide mark done task modal
  void showMarkDoneTaskModal(Task task) {
    this.appState = AppState.MarkingDoneTask;
    this.taskBeingMarkedDone = task;
    notifyListeners();
  }

  void hideMarkDoneTaskModal() {
    this.appState = AppState.ViewingTasks;
    notifyListeners();
  }

// show and hide mark undone task modal
  void showMarkUndoneTaskModal(Task task) {
    this.appState = AppState.MarkingUndoneTask;
    this.taskBeingMarkedUndone = task;
    notifyListeners();
  }

  void hideMarkUndoneTaskModal() {
    this.appState = AppState.ViewingTasks;
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
