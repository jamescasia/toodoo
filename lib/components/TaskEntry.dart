import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/views/MarkDoneTaskModal.dart';
import 'package:toodoo/views/MarkUndoneTaskModal.dart';

import '../models/AppModel.dart';
import '../models/Task.dart';
import '../utils/Constants.dart';

/* 
TaskEntry is the widget for the specific task.
*/
class TaskEntry extends StatelessWidget {
  TaskEntry(this.task);

  Task task;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return InkWell(
        onTap: () {
          task.expanded = !task.expanded;
          appModel.updateTask(task);
        },
        child: AnimatedContainer(
          key: Key('task-entry-${task.title}'),
          height: task.expanded ? 160 : 60,
          width: Constants.maxWidth * 0.8,
          margin: EdgeInsets.symmetric(vertical: 8.5),
          duration: Duration(milliseconds: 120),
          curve: Curves.easeInCirc,
          decoration: BoxDecoration(
              color: Constants.noteColor,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: Offset(0, 1))
              ]),
          child: Column(children: [
            Container(
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    key: Key('task-entry-mark-btn-${task.title}'),
                    onTap: () {
                      if (!task.done) {
                        appModel.showMarkDoneTaskModal(task);
                      } else {
                        appModel.showMarkUndoneTaskModal(task);
                      }
                    },
                    child: Container(
                        width: 34,
                        height: 34,
                        key: Key('task-entry-mark-status-${task.title}'),
                        decoration: BoxDecoration(
                            color: task.done
                                ? Constants.doneColor
                                : Constants.notDonecolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(999))),
                        child: Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(999))),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    task.title,
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.bold,
                        color: Constants.textColor,
                        fontSize: 18),
                  ),
                  Spacer(),
                  InkWell(
                    key: Key('task-entry-del-btn-${task.title}'),
                    onTap: () {
                      appModel.showDeleteTaskModal(task);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: Constants.delColor,
                          borderRadius: BorderRadius.all(Radius.circular(999))),
                      child: Center(
                          child: Container(
                        width: 16,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(999))),
                      )),
                    ),
                  )
                ],
              ),
            ),
            task.expanded
                ? Container(
                    height: 104,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      color: Constants.noteColorLight,
                    ),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          task.description,
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              color: Constants.textColor.withOpacity(0.8),
                              fontWeight: FontWeight.w400),
                        )),
                  )
                : SizedBox()
          ]),
        ),
      );
    });
  }
}
