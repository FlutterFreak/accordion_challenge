import 'package:accordion_challenge/model/groupModel.dart';
import 'package:accordion_challenge/widgets/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Material(child: widget),
        ));
  }

  testWidgets('test task widget', (WidgetTester tester) async {
    TaskWidget widget = TaskWidget(
        task: Tasks(
          description: "Say hello to random person",
          value: 20,
          checked: true,
        ),
        context: MockBuildContext(),
        groupIndex: 0,
        taskIndex: 0);
    await tester.pumpWidget(buildTestableWidget(widget));
    expect(find.byKey(Key('taskWidget')), findsOneWidget);
    await tester.pump();
    await tester.tap(find.text('Say hello to random person'));
    await tester.pump();
  });
}
