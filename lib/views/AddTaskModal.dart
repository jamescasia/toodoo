import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/Task.dart';

import '../models/AppModel.dart';
import '../utils/Constants.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({Key? key}) : super(key: key);

  @override
  _AddTaskModalState createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final FocusNode titleFocus = FocusNode();
  final FocusNode descFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      print("state");
      print(appModel.appState);
      return InkWell(
        onTap: () {
          appModel.hideAddTaskModal();
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            Center(
              child: Container(
                height: 180,
                width: Constants.maxWidth * 0.8,
                margin: EdgeInsets.symmetric(vertical: 8.5),
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
                      padding: EdgeInsets.only(left: 24, right: 24, top: 14),
                      child: Center(
                        child: TextField(
                          controller: titleController,
                          maxLength: 35,
                          maxLines: 1,
                          focusNode: titleFocus,
                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(descFocus);
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "Task name...",
                              hintStyle: TextStyle(
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.bold,
                                  color: Constants.textColor.withOpacity(0.6),
                                  fontSize: 18)),
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Constants.textColor.withOpacity(0.8),
                              fontSize: 18),
                        ),
                      )),
                  Container(
                    height: 120,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(42)),
                      color: Constants.noteColorLight,
                    ),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: TextField(
                          controller: descController,
                          maxLength: 100,
                          maxLines: 3,
                          focusNode: descFocus,
                          onSubmitted: (text) {
                            if (titleController.text.isNotEmpty) {
                              Task task = Task(
                                  titleController.text +
                                      Random()
                                          .nextInt(pow(2, 32).toInt())
                                          .toString(),
                                  titleController.text,
                                  descController.text,
                                  false,
                                  true);

                              appModel.addTask(task);
                              appModel.hideAddTaskModal();
                              FocusScope.of(context).requestFocus(FocusNode());
                              titleController.text = "";
                              descController.text = "";
                            }
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "Add task description...",
                              hintStyle: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 16,
                                  color: Constants.textColor.withOpacity(0.6),
                                  fontWeight: FontWeight.w300)),
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              color: Constants.textColor.withOpacity(0.8),
                              fontWeight: FontWeight.w400),
                        )),
                  )
                ]),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: MaterialButton(
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
                      "assets/icons/check_icon.png",
                    ),
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        Task task = Task(
                            titleController.text +
                                Random().nextInt(pow(2, 32).toInt()).toString(),
                            titleController.text,
                            descController.text,
                            false,
                            true);

                        appModel.addTask(task);
                        appModel.hideAddTaskModal();
                        FocusScope.of(context).requestFocus(FocusNode());
                        titleController.text = "";
                        descController.text = "";
                      }
                    })),
          ],
        ),
      );
    });
  }
}