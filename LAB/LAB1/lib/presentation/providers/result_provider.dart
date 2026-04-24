import 'package:flutter/foundation.dart';
import 'package:task/data/repository.dart';
import 'package:task/domain/logic.dart';
import 'package:task/domain/models/student_result.dart';

class ResultProvider extends ChangeNotifier {
  String _name = '';
  String _digits = '';
  StudentResult? _result;
  String _error = '';
  bool _isLoading = false;

  String get name => _name;
  String get digits => _digits;
  StudentResult? get result => _result;
  String get error => _error;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    final data = await StudentRepository.loadData();
    _name = data['name']!;
    _digits = data['digits']!;
    _isLoading = false;
    notifyListeners();
  }

  void updateName(String value) {
    _name = value.trim();
    notifyListeners();
  }

  void updateDigits(String value) {
    if (value.length <= 4 && RegExp(r'^\d*$').hasMatch(value)) {
      _digits = value;
      notifyListeners();
    }
  }

  Future<void> calculate() async {
    _error = '';
    if (_name.isEmpty) {
      _error = 'Student name cannot be empty.';
      notifyListeners();
      return;
    }
    if (_digits.length != 4) {
      _error = 'Please enter exactly 4 digits.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await StudentRepository.saveData(_name, _digits);
      final marks = parseMarksFromDigits(_digits);
      final total = calculateTotal(marks);
      final average = calculateAverage(total, marks.length);
      final status = determineResult(average);

      _result = StudentResult(
        name: _name,
        marks: marks,
        total: total,
        average: average,
        status: status,
      );
    } catch (_) {
      _error = 'Calculation failed unexpectedly.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _name = '';
    _digits = '';
    _result = null;
    _error = '';
    StudentRepository.clearData();
    notifyListeners();
  }
}
