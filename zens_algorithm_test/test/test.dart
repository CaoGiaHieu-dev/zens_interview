import 'package:test/test.dart';
import 'package:zens_algorithm_test/zens_algorithm_test.dart';

void main() {
  group('Excuse test case', () {
    test('Example case 0', () {
      miniMaxSum(
        [1, 3, 5, 7, 9],
      );
    });

    test('Example case 1', () {
      miniMaxSum(
        [1, 2, 3, 4, 5],
      );
    });
  });
}
