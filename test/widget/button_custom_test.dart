import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bug_away/Core/component/button_custom.dart';

void main() {
  group('ButtonCustom Widget Tests', () {
    Widget createTestWidget({
      String buttonName = 'Test Button',
      VoidCallback? onTap,
      bool enable = true,
      IconData? icon,
    }) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: ButtonCustom(
              buttonName: buttonName,
              onTap: onTap ?? () {},
              enable: enable,
              icon: icon,
            ),
          ),
        ),
      );
    }

    testWidgets('should render button with correct text',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(buttonName: 'Login'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('should call onTap when pressed', (WidgetTester tester) async {
      // Arrange
      bool wasTapped = false;

      // Act
      await tester.pumpWidget(createTestWidget(
        buttonName: 'Submit',
        onTap: () {
          wasTapped = true;
        },
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(wasTapped, isTrue);
    });

    testWidgets('should not call onTap when disabled',
        (WidgetTester tester) async {
      // Arrange
      bool wasTapped = false;

      // Act
      await tester.pumpWidget(createTestWidget(
        buttonName: 'Submit',
        onTap: () {
          wasTapped = true;
        },
        enable: false,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(wasTapped, isFalse);
    });

    testWidgets('should render with icon when provided',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(
        buttonName: 'Next',
        icon: Icons.arrow_forward,
      ));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('should find ElevatedButton widget',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
