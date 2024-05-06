// ignore_for_file: public_member_api_docs, sort_constructors_first
class OpenOrder {
  final String symbol;
  final String side;
  final String size;
  final String avgPrice;
  final String positionValue;
  final String markPrice;
  final String unrealisedPnl;

  final String createdTime;

  OpenOrder({
    required this.symbol,
    required this.side,
    required this.size,
    required this.avgPrice,
    required this.positionValue,
    required this.markPrice,
    required this.unrealisedPnl,
    required this.createdTime,
  });

  factory OpenOrder.fromJson(Map<String, dynamic> json) {
    return OpenOrder(
        symbol: json['symbol'] ?? 'N/A',
        side: json['side'] ?? 'N/A',
        size: json['size'] ?? 'N/A',
        avgPrice: json['avgPrice'] ?? 'N/A',
        positionValue: json['positionValue'] ?? 'N/A',
        markPrice: json['markPrice'] ?? 'N/A',
        unrealisedPnl: json['unrealisedPnl'] ?? 'N/A',
        createdTime: json['createdTime'] ?? 'N/A');
  }
}
