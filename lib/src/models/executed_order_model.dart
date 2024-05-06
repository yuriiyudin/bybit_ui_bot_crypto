class ExecutedOrder {
  final String symbol;
  final String side;
  final String qty;
  final String orderPrice;
  final String avgEntryPrice;

  final String avgExitPrice;
  final String closedPnl;
  final String cumEntryValue;
  final String cumExitValue;

  final String createdTime;

  final String orderId;

  ExecutedOrder({
    required this.symbol,
    required this.side,
    required this.qty,
    required this.orderPrice,
    required this.avgEntryPrice,
    required this.avgExitPrice,
        required this.cumEntryValue,
    required this.cumExitValue,
    required this.closedPnl,
    required this.createdTime,
    required this.orderId,
  });

  factory ExecutedOrder.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.now();

    // Получаем часовой пояс UTC+3

    // Конвертируем дату и время в UTC+3

    return ExecutedOrder(
      symbol: json['symbol'] ?? 'N/A',
      side: json['side']?? 'N/A',
      qty: json['qty']?? 'N/A',
      orderPrice: json['orderPrice']?? 'N/A',
      avgEntryPrice: json['avgEntryPrice'] ?? 'N/A',
      avgExitPrice: json['avgExitPrice']?? 'N/A',
      closedPnl: json['closedPnl']?? 'N/A',
      createdTime: json['createdTime']?? 'N/A',
      cumEntryValue: json['cumEntryValue']?? 'N/A',
      cumExitValue: json['closedSize']?? 'N/A',
      orderId: json['orderId']?? 'N/A',
    );
  }
}
