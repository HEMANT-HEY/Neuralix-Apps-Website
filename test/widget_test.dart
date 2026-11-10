import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neuralixapps/main.dart';

void main() {
  testWidgets('NeuralixApp loads smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const NeuralixApp());
    expect(find.byType(NeuralixApp), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
