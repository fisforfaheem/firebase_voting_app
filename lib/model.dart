class MockBandInfo {
  final String name;
  final int votes;

  MockBandInfo({required this.name, required this.votes});

  static MockBandInfo fromMap(Map<String, dynamic> map) {
    return MockBandInfo(
      name: map['name'],
      votes: map['votes'],
    );
  }
}
