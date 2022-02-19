import 'package:flutter/material.dart';

import '../models/Task.dart';
import '../utils/Constants.dart';

class TaskEntry extends StatefulWidget {
  TaskEntry(this.task);

  Task task;

  @override
  _TaskEntryState createState() => _TaskEntryState(this.task);
}

class _TaskEntryState extends State<TaskEntry> {
  _TaskEntryState(this.task);

  Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          task.expanded = !task.expanded;
        });
      },
      child: AnimatedContainer(
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
                  onTap: () {
                    setState(() {
                      task.done = !task.done;
                    });
                  },
                  child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                          color: task.done
                              ? Constants.doneColor
                              : Constants.notDonecolor,
                          borderRadius: BorderRadius.all(Radius.circular(999))),
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
                  onTap: () {},
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(999))),
                    child: Center(
                        child: Container(
                      width: 16,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(999))),
                    )),
                  ),
                )
              ],
            ),
          ),
          task.expanded
              ? Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(42)),
                    color: Constants.noteColorLight,
                  ),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        task.description,
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      )),
                )
              : SizedBox()
        ]),
      ),
    );
  }
}
