import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bug_away/Core/component/text_feild_custom.dart';

void main() {
  group('CustomTextFormField Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    Widget createTestWidget({
      String hint = 'Test Hint',
      String? Function(String?)? validator,
      bool isSecured = false,
      bool enable = true,
    }) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              hint: hint,
              controller: controller,
              validator: validator ?? (val) => null,
              isSecured: isSecured,
              enable: enable,
            ),
          ),
        ),
      );
    }

    testWidgets('should render with hint text', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(hint: 'Enter email'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Enter email'), findsOneWidget);
    });

    testWidgets('should accept text input', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Act
      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      await tester.pumpAndSettle();

      // Assert
      expect(controller.text, equals('test@example.com'));
    });

    testWidgets('should show validation error when validator returns error',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: Form(
                autovalidateMode: AutovalidateMode.always,
                child: CustomTextFormField(
                  hint: 'Email',
                  controller: controller,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - empty field should show error
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('should render password field when isSecured is true',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(
        hint: 'Password',
        isSecured: true,
      ));
      await tester.pumpAndSettle();

      // Assert - find TextFormField widget
      expect(find.byType(TextFormField), findsOneWidget);
      // The password field should be rendered (we verify the widget exists)
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should be disabled when enable is false',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(enable: false));
      await tester.pumpAndSettle();

      // Assert
      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });
  });
}
