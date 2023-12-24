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

  // static List<MockBandInfo> bandList = [
  //   MockBandInfo(name: 'Metallica', votes: 5),
  //   MockBandInfo(name: 'Queen', votes: 3),
  //   MockBandInfo(name: 'AC/DC', votes: 2),
  //   MockBandInfo(name: 'Bon Jovi', votes: 1),
  // ];
}
