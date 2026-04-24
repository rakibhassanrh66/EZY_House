class UserModel {
  final String name;
  final String accountNumber;

  UserModel({
    required this.name,
    required this.accountNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'accountNumber': accountNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      accountNumber: map['accountNumber'] as String,
    );
  }
}
