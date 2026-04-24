class MessageModel {
  final String id;
  final String senderName;
  final String lastMessage;
  final DateTime time;
  final bool isRead;
  final String? avatar;

  MessageModel({
    required this.id,
    required this.senderName,
    required this.lastMessage,
    required this.time,
    this.isRead = false,
    this.avatar,
  });
}

final List<MessageModel> dummyMessages = [
  MessageModel(
    id: '1',
    senderName: 'John Smith',
    lastMessage: 'Is the apartment still available?',
    time: DateTime.now().subtract(const Duration(minutes: 5)),
    isRead: false,
  ),
  MessageModel(
    id: '2',
    senderName: 'Sarah Johnson',
    lastMessage: 'Thank you for the tour!',
    time: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: true,
  ),
  MessageModel(
    id: '3',
    senderName: 'Mike Wilson',
    lastMessage: 'When can I move in?',
    time: DateTime.now().subtract(const Duration(days: 1)),
    isRead: true,
  ),
  MessageModel(
    id: '4',
    senderName: 'Emily Brown',
    lastMessage: 'Great property!',
    time: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
  MessageModel(
    id: '5',
    senderName: 'David Lee',
    lastMessage: 'Can we schedule a viewing?',
    time: DateTime.now().subtract(const Duration(days: 3)),
    isRead: true,
  ),
];
