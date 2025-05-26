// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:peru_dash_app/main_customer.dart'; // Changed import

void main() {
  testWidgets('Customer App UI Smoke Test', (WidgetTester tester) async { // Renamed test
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CustomerApp()); // Changed to CustomerApp

    // Verify that the main title is present.
    expect(find.text('Bienvenido a Andafast!'), findsOneWidget);

    // Verify that the 'Ingresar' button is present.
    expect(find.widgetWithText(ElevatedButton, 'Ingresar'), findsOneWidget);

    // Verify that the 'Registrarse' button is present.
    expect(find.widgetWithText(ElevatedButton, 'Registrarse'), findsOneWidget);

    // Example: Tap the 'Registrarse' button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Registrarse'));
    await tester.pump();

    // After tapping 'Registrarse', check for an element specific to the registration form
    // For example, the "Nombre completo" text field.
    expect(find.text('Nombre completo'), findsOneWidget);
  });
}
