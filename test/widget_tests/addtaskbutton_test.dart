import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toodoo/main.dart';
import 'package:toodoo/views/AddTaskModal.dart';

void main() {
  group('Add Task Button', () {
    testWidgets('Tapping Addtask button should trigger Add task modal to show',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Tap the  add task button to trigger frame
      await tester.tap(find.byKey(Key('add-task-btn')));
      await tester.pump();

      // Verify that the AddTaskModal has popped up
      expect(find.byWidgetPredicate((widget) => widget is AddTaskModal),
          findsOneWidget);
    });
  });
}
