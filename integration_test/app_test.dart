import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:test_app_fizikl/main.dart';

Future<void> addDelay(int sec) async {
  await Future<void>.delayed(Duration(seconds: sec));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('end-to-end test', () {
    final timeDataEmail = '${DateTime.now().microsecondsSinceEpoch}@test.com';

    testWidgets('signIn', (WidgetTester tester) async {
      await Firebase.initializeApp();
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('SignInFormLogin')), '1111@mail.test');
      await tester.enterText(find.byKey(const ValueKey('SignInFormPassword')), '123456');
      await tester.tap(find.byKey(const ValueKey('SignInButton')));
      await addDelay(3);
      expect(find.byKey(const ValueKey('SignOutButton')), findsOneWidget);
      await logout(tester);
    });

    testWidgets('signOut', (WidgetTester tester) async {
      await Firebase.initializeApp();
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('SignInFormLogin')), '1111@mail.test');
      await tester.enterText(find.byKey(const ValueKey('SignInFormPassword')), '123456');
      await tester.tap(find.byKey(const ValueKey('SignInButton')));
      await addDelay(3);
      await tester.tap(find.byKey(const ValueKey('SignOutButton')));
      await addDelay(3);
      expect(find.byKey(const ValueKey('SignInButton')), findsOneWidget);
    });

    testWidgets('signUp', (WidgetTester tester) async {
      await Firebase.initializeApp();
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('SignUpButton')));
      await addDelay(3);
      await tester.enterText(find.byKey(const ValueKey('SignUpFormLogin')), timeDataEmail);
      await tester.enterText(find.byKey(const ValueKey('SignUpFormPassword')), '1234567');
      await tester.tap(find.byKey(const ValueKey('SignUpConfirmButton')));
      await addDelay(3);
      expect(find.byKey(const ValueKey('SignOutButton')), findsOneWidget);
      await logout(tester);
    });
  });
}
Future<void> logout(WidgetTester tester) async {
  await tester.tap(find.byKey(
    const ValueKey('SignOutButton'),
  ));
  await tester.pumpAndSettle();
}