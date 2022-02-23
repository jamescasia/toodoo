import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toodoo/components/TaskEntry.dart';
import 'package:toodoo/main.dart';
import 'package:toodoo/views/AddTaskModal.dart';

void main() {
  group('Add Task Modal:', () {
    testWidgets('Tapping outside the Add Task Modal dismisses the modal',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Tap the  add task button to show the Add Task Modal
      await tester.tap(find.byKey(const Key('add-task-btn')));
      await tester.pump();

      // Verify that the AddTaskModal has popped up
      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsOneWidget);

      // Press add task modal barrier
      await tester.tap(find.byKey(Key('add-task-modal-barrier')));
      await tester.pump();
      // Add Task Modal should be dismissed
      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsNothing);
    });

    testWidgets(
        'Tapping on the add task button after entering task name and description adds the task',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Tap the  add task button to show the Add Task Modal
      await tester.tap(find.byKey(const Key('add-task-btn')));
      await tester.pump();

      // Verify that the AddTaskModal has popped up
      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsOneWidget);

      // Fill task name  and description field
      await tester.enterText(
          find.byKey(const Key('add-task-modal-title-field')), "Test Task");
      await tester.pump();
      await tester.enterText(find.byKey(const Key('add-task-modal-desc-field')),
          "Test Task description");
      await tester.pump();
      // Press the submit button
      await tester.tap(find.byKey(const Key('add-task-modal-submit-btn')));

      // wait for a couple seconds to ensure task is added.
      await tester.pump(Duration(seconds: 1));

      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsNothing);
      expect(find.byKey(Key('task-entry-Test Task')), findsOneWidget);
    });
  });
}
