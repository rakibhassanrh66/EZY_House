// Defensive & pure functions for domain logic

/// Splits 4-digit string into 3 subject marks (0-100 range)
/// Format: First 2 digits = Sub1, 3rd digit * 10 = Sub2, 4th digit * 10 = Sub3
List<int> parseMarksFromDigits(String fourDigits) {
  if (fourDigits.length != 4) return [];
  final d = fourDigits.split('');
  return [
    int.tryParse('${d[0]}${d[1]}') ?? 0,
    (int.tryParse(d[2]) ?? 0) * 10,
    (int.tryParse(d[3]) ?? 0) * 10,
  ];
}

int calculateTotal(List<int> marks) {
  return marks.isEmpty ? 0 : marks.reduce((a, b) => a + b);
}

double calculateAverage(int total, int subjectCount) {
  if (subjectCount <= 0) return 0.0;
  return total / subjectCount;
}

String determineResult(double average) {
  return average >= 50.0 ? 'PASS' : 'FAIL';
}
