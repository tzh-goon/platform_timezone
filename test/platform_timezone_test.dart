import 'package:flutter/services.dart';
import 'package:platform_timezone/platform_timezone.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('platform_timezone');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getLocalTimezone', () async {
    expect(await PlatformTimezone.getLocalTimezone(), '42');
  });
}
