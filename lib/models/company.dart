class Company {
  final String id;
  final String name;

  const Company({required this.id, required this.name});

  factory Company.fromMap(Map<String, dynamic> map) => Company(
        id: map['id'],
        name: map['name'],
      );
}
