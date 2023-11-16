void miniMaxSum(List<int> arr) {
  int? minValue;
  int? maxValue;
  int totalInArr = 0;

  for (var i in arr) {
    totalInArr += i;

    //get min value
    if (i < (minValue ?? i + 1)) {
      minValue = i;
    }

    //get max value
    if (i > (maxValue ?? i - 1)) {
      maxValue = i;
    }
  }

  assert(maxValue != null);
  assert(minValue != null);
  print('MinimumSum ${totalInArr - maxValue!}');
  print('MaximumSum ${totalInArr - minValue!}');
}
