import 'package:accordion_challenge/model/groupModel.dart';
import 'package:accordion_challenge/widgets/groupWidget.dart';
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

  testWidgets('test group widget', (WidgetTester tester) async {
    GroupWidget widget = GroupWidget(list: [
      GroupModel(
          name: "General Infos",
          tasks: [
            Tasks(
              description: "Add name and surname",
              value: 10,
              checked: true,
            ),
            Tasks(description: "Add email", value: 20, checked: false),
          ],
          show: true)
    ], context: MockBuildContext());
    await tester.pumpWidget(buildTestableWidget(widget));
    expect(find.byKey(Key('groupTile')), findsOneWidget);
    await tester.pump();
    await tester.tap(find.text('Add name and surname'));
    await tester.pump();
  });
}
