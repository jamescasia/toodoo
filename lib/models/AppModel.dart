import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/Task.dart';
import 'package:toodoo/services/ApiProvider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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
  http.Client client = http.Client();

  // Buildcontext passed for showing toast.
  BuildContext? context;

  AppModel() {
    inititalizeTasks();
  }
// setting context. Required for show toast
  setContext(BuildContext ctx) {
    this.context = ctx;
  }

// iniitalize tasks
  inititalizeTasks() async {
    this.setTasks(await getTasks());
    notifyListeners();
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

//  fetch tasks
  Future<List<Task>> getTasks() async {
    try {
      return await ApiProvider().fetchTasks();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to get tasks. Please check network connection.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return [];
    }
  }

  // add task to tasks
  void addTask(task) async {
    this.tasks.add(task);
    if (this.viewingState != ViewingState.NotDone) {
      this.tasksBeingViewed.add(task);
    }
    notifyListeners();
    try {
      await ApiProvider().uploadTask(task);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to upload task. Please check network connection.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //  Delete task
  void deleteTask(task) async {
    this.tasks.retainWhere((t) => t.id != task.id);
    this.tasksBeingViewed.retainWhere((t) => t.id != task.id);
    notifyListeners();
    try {
      await ApiProvider().deleteTask(task);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to delete task. Please check network connection.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

// Update task
  void updateTask(task) async {
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
    try {
      await ApiProvider().updateTask(task);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to update task. Please check network connection.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
