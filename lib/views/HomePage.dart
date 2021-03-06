import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/components/TaskEntry.dart';
import 'package:toodoo/utils/Constants.dart';
import 'package:toodoo/components/LabelChip.dart';
import 'package:toodoo/views/AddTaskModal.dart';
import 'package:toodoo/utils/ScrollBehaviour.dart';
import 'package:toodoo/views/DeleteTaskModal.dart';
import 'package:toodoo/views/MarkDoneTaskModal.dart';
import 'package:toodoo/views/MarkUndoneTaskModal.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import '../models/AppModel.dart';
import '../models/Task.dart';

/* 
Home Page is the single page for the app.
*/
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants.maxWidth = MediaQuery.of(context).size.width;
    Constants.maxHeight = MediaQuery.of(context).size.height;

    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return SimpleGestureDetector(
        onHorizontalSwipe: (dir) {
          // Right Swipe
          if (dir == SwipeDirection.right) {
            if (appModel.viewingState == ViewingState.NotDone) {
              appModel.viewDoneTasks();
            } else if (appModel.viewingState == ViewingState.Done) {
              appModel.viewAllTasks();
            }
            //Left Swipe
          } else if (dir == SwipeDirection.left) {
            if (appModel.viewingState == ViewingState.All) {
              appModel.viewDoneTasks();
            } else if (appModel.viewingState == ViewingState.Done) {
              appModel.viewNotDoneTasks();
            }
          }
        },
        child: Scaffold(
          body: Container(
            color: Constants.bgColor,
            child: Stack(
              children: [
                Center(
                  child: Container(
                      width: Constants.maxWidth * 0.85,
                      height: Constants.maxHeight,
                      child: CustomScrollView(
                          scrollBehavior: CustomScrollBehaviour(),
                          slivers: <Widget>[
                            SliverAppBar(
                              backgroundColor: Constants.bgColor,
                              expandedHeight: 140,
                              collapsedHeight: 95,
                              elevation: 0,
                              flexibleSpace: Center(
                                child: Container(
                                  width: Constants.maxWidth * 0.86,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Toodoo",
                                          style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 42,
                                              color: Constants.textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            height: 50,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            padding: EdgeInsets.only(left: 20),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      appModel.viewAllTasks();
                                                    },
                                                    child: LabelChip(
                                                        "all",
                                                        appModel.viewingState ==
                                                            ViewingState.All,
                                                        Constants.allColor),
                                                  ),
                                                  InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      appModel.viewDoneTasks();
                                                    },
                                                    child: LabelChip(
                                                        "done",
                                                        appModel.viewingState ==
                                                            ViewingState.Done,
                                                        Constants.doneColor),
                                                  ),
                                                  InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      appModel
                                                          .viewNotDoneTasks();
                                                    },
                                                    child: LabelChip(
                                                        "not done",
                                                        appModel.viewingState ==
                                                            ViewingState
                                                                .NotDone,
                                                        Constants.notDonecolor),
                                                  )
                                                ]))
                                      ]),
                                ),
                              ),
                              floating: false,
                              pinned: true,
                            ),
                            // SliverAnimatedList(
                            //   key: GlobalKey<SliverAnimatedListState>(),
                            //   itemBuilder: (context, index, animation) =>
                            //       TaskEntry(
                            //           appModel.tasksBeingViewed
                            //               .elementAt(index),
                            //           animation),
                            //   initialItemCount:
                            //       appModel.tasksBeingViewed.length,
                            // ),
                            SliverList(
                                delegate: SliverChildListDelegate(appModel
                                    .tasksBeingViewed
                                    .map((task) => TaskEntry(task))
                                    .toList()))
                          ])),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                        key: Key('add-task-btn'),
                        height: 72,
                        minWidth: 72,
                        color: Constants.fabColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(33),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(45),
                        )),
                        child: Image.asset(
                          "assets/icons/plus_icon.png",
                        ),
                        onPressed: () {
                          appModel.showAddTaskModal();
                        })),
                appModel.appState == AppState.AddingTask
                    ? AddTaskModal()
                    : appModel.appState == AppState.DeletingTask
                        ? DeleteTaskModal(appModel.taskBeingDeleted)
                        : appModel.appState == AppState.MarkingDoneTask
                            ? MarkDoneTaskModal(appModel.taskBeingMarkedDone)
                            : appModel.appState == AppState.MarkingUndoneTask
                                ? MarkUndoneTaskModal(
                                    appModel.taskBeingMarkedUndone)
                                : SizedBox()

                // AddTaskModal()
              ],
            ),
          ),
        ),
      );
    });
  }
}
