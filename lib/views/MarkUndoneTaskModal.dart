import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toodoo/models/AppModel.dart';
import 'package:toodoo/models/Task.dart';
import 'package:toodoo/utils/Constants.dart';

/* MarkUndoneTaskModal is a modal for marking at ask as not done*/
class MarkUndoneTaskModal extends StatefulWidget {
  MarkUndoneTaskModal(this.task);
  Task? task;

  @override
  _MarkUndoneTaskModalState createState() =>
      _MarkUndoneTaskModalState(this.task);
}

class _MarkUndoneTaskModalState extends State<MarkUndoneTaskModal> {
  _MarkUndoneTaskModalState(this.task);
  Task? task;
  @override
  double popupWidth = 200;
  double popupHeight = 0;

  void afterBuild(BuildContext context) {
    setState(() {
      popupWidth = Constants.maxWidth * 0.8;
      popupHeight = 160;
    });
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => afterBuild(context));
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Stack(
        children: [
          Container(
            color: Constants.notDonecolor.withOpacity(0.9),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Mark as not done?",
                style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 38,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 110),
                curve: Curves.bounceIn,
                height: popupHeight,
                width: popupWidth,
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
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                                color: task!.done
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
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          task!.title,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.bold,
                              color: Constants.textColor,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          task!.description,
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              color: Constants.textColor.withOpacity(0.8),
                              fontWeight: FontWeight.w400),
                        )),
                  )
                ]),
              ),
            ],
          )),
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
                    appModel.markTaskAsUndone();
                    appModel.hideMarkUndoneTaskModal();
                  })),
          Positioned(
              bottom: 0,
              left: 0,
              child: MaterialButton(
                  height: 72,
                  minWidth: 72,
                  color: Constants.allColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(33),
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(40),
                  )),
                  child: Image.asset(
                    "assets/icons/cross_icon.png",
                    width: 41,
                  ),
                  onPressed: () {
                    appModel.hideMarkUndoneTaskModal();
                  })),
        ],
      );
    });
  }
}
