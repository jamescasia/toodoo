import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toodoo/components/TaskEntry.dart';
import 'package:toodoo/utils/Constants.dart';
import 'package:toodoo/components/LabelChip.dart';
import 'package:toodoo/utils/ScrollBehaviour.dart';

import '../models/Task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tasks = [
    Task(1, "Walk the dogs", "walk the dogs in ayala and do 5 laps", false),
    Task(2, "Follow your tempo",
        "Follow follow follow follow your tempo your follow follow", true),
    Task(3, "Get laundry", "Get laundry at laundryhouse at 3PM", true),
    Task(
        4,
        "Study for Calculus exam",
        "Study for calculus exam: Limits, Infinite Series, Limits at Infinity",
        false),
    Task(1, "Walk the dogs", "walk the dogs in ayala and do 5 laps", false),
    Task(2, "Follow your tempo",
        "Follow follow follow follow your tempo your follow follow", true),
    Task(3, "Get laundry", "Get laundry at laundryhouse at 3PM", true),
    Task(
        4,
        "Study for Calculus exam",
        "Study for calculus exam: Limits, Infinite Series, Limits at Infinity",
        false),
  ];
  @override
  Widget build(BuildContext context) {
    Constants.maxWidth = MediaQuery.of(context).size.width;
    Constants.maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        padding: EdgeInsets.only(left: 20),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              LabelChip("all", true,
                                                  Constants.allColor),
                                              LabelChip("done", false,
                                                  Constants.doneColor),
                                              LabelChip("not done", false,
                                                  Constants.notDonecolor)
                                            ]))
                                  ]),
                            ),
                          ),
                          floating: false,
                          pinned: true,
                        ),
                        // Column(
                        //   children:
                        //       tasks.map((task) => TaskEntry(task, false)).toList(),
                        // ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            tasks
                                .map((task) => TaskEntry(task, false))
                                .toList(),
                          ),
                        ),
                      ])),
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
                      "assets/icons/plus_icon.png",
                    ),
                    onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
