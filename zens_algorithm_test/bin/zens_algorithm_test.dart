import 'package:zens_algorithm_test/zens_algorithm_test.dart'
    as zens_algorithm_test;

void main(List<String> arguments) {
  if (arguments.isEmpty) return;
  final arr = arguments.join('').split(' ').map((e) => int.parse(e)).toList();
  zens_algorithm_test.miniMaxSum(arr);
}
