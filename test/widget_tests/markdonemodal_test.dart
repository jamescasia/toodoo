import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toodoo/components/TaskEntry.dart';
import 'package:toodoo/main.dart';
import 'package:toodoo/utils/Constants.dart';
import 'package:toodoo/views/AddTaskModal.dart';
import 'package:toodoo/views/DeleteTaskModal.dart';
import 'package:toodoo/views/MarkDoneTaskModal.dart';

void main() {
  group('Mark Done Task Modal:', () {
    testWidgets('Tapping the close button dismisses the modal',
        (WidgetTester tester) async {
      // ADD A TASK TO DELETE
      await tester.pumpWidget(const MyApp());

      // Tap the  add task button to show the Add Task Modal
      await tester.tap(find.byKey(const Key('add-task-btn')));
      await tester.pump();

      // Verify that the AddTaskModal has popped up
      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsOneWidget);

      // Fill task name and description field
      await tester.enterText(
          find.byKey(const Key('add-task-modal-title-field')), "Test Task");
      await tester.pump();
      await tester.enterText(find.byKey(const Key('add-task-modal-desc-field')),
          "Test Task description");
      await tester.pump();
      // Press the submit button
      await tester.tap(find.byKey(const Key('add-task-modal-submit-btn')));

      await tester.pump(Duration(seconds: 1));
      // wait for a couple seconds to ensure task is added.

      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsNothing);
      expect(find.byKey(Key('task-entry-Test Task')), findsOneWidget);

      // Marking the task
      await tester.tap(find.byKey(Key('task-entry-mark-btn-Test Task')));
      await tester.pump();

      expect(find.byWidgetPredicate((widget) => widget is MarkDoneTaskModal),
          findsOneWidget);

      // Tap the close button
      await tester.tap(find.byKey(Key('mark-task-modal-close-btn')));
      await tester.pump();

      expect(find.byWidgetPredicate((widget) => widget is MarkDoneTaskModal),
          findsNothing);
    });

    testWidgets(
        'Tapping the check button dismisses the modal and marks done the task',
        (WidgetTester tester) async {
      // ADD A TASK TO DELETE
      await tester.pumpWidget(const MyApp());

      // Tap the  add task button to show the Add Task Modal
      await tester.tap(find.byKey(const Key('add-task-btn')));
      await tester.pump();

      // Verify that the AddTaskModal has popped up
      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsOneWidget);

      // Fill task name and description field
      await tester.enterText(
          find.byKey(const Key('add-task-modal-title-field')), "Test Task");
      await tester.pump();
      await tester.enterText(find.byKey(const Key('add-task-modal-desc-field')),
          "Test Task description");
      await tester.pump();
      // Press the submit button
      await tester.tap(find.byKey(const Key('add-task-modal-submit-btn')));

      await tester.pump(Duration(seconds: 1));
      // wait for a couple seconds to ensure task is added.

      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsNothing);
      expect(find.byKey(Key('task-entry-Test Task')), findsOneWidget);

      // Marking the task
      await tester.tap(find.byKey(Key('task-entry-mark-btn-Test Task')));
      await tester.pump();

      expect(find.byWidgetPredicate((widget) => widget is MarkDoneTaskModal),
          findsOneWidget);

      // Tap the check button
      await tester.tap(find.byKey(Key('mark-task-modal-check-btn')));
      await tester.pump();

      expect(find.byWidgetPredicate((widget) => widget is MarkDoneTaskModal),
          findsNothing);
      expect(
          (((tester.firstWidget(
                          find.byKey(Key('task-entry-mark-status-Test Task')))
                      as Container)
                  .decoration) as BoxDecoration)
              .color,
          Constants.doneColor);
    });
  });
}
