class MockBandInfo {
  final String name;
  final int votes;

  MockBandInfo({required this.name, required this.votes});

  static List<MockBandInfo> bandList = [
    MockBandInfo(name: 'Metallica', votes: 5),
    MockBandInfo(name: 'Queen', votes: 3),
    MockBandInfo(name: 'AC/DC', votes: 2),
    MockBandInfo(name: 'Bon Jovi', votes: 1),
  ];
}
