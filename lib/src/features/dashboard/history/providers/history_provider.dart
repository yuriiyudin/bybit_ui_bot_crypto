import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_octopus/src/constants/api_keys.dart';
import 'package:terminal_octopus/src/models/executed_order_model.dart';

// v5/order/history

// category linear

class HistoryNotifier extends StateNotifier<List<ExecutedOrder>> {
  HistoryNotifier() : super([]);

  Future<void> fetchHistory() async {
    final int recvWindow = 5000;
    final String url = "https://api.bybit.com";
    // final String url = "https://api-demo.bybit.com";
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final expires = ((DateTime.now().millisecondsSinceEpoch + 1) * 1000);

    final hmacSha256 = Hmac(sha256, const Utf8Encoder().convert(apiSecret));
    String payload = 'category=linear&settleCoin=USDT'; //
    final String paramStr = "$timestamp$apiKey$recvWindow$payload";
    final Digest sign = hmacSha256.convert(utf8.encode(paramStr));

    // String encoder =  base64Encode(hash);

    Dio dio = Dio();

    String endpoint = "/v5/position/closed-pnl"; // Замените на ваш реальный путь к API
    String method = "GET"; // или "POST"

    String info = "Information about the request";

    Options options = Options(
      headers: {
        'X-BAPI-SIGN-TYPE': '2',
        'X-BAPI-SIGN': sign,
        'X-BAPI-API-KEY': apiKey,
        'X-BAPI-TIMESTAMP': timestamp,
        'X-BAPI-RECV-WINDOW': recvWindow.toString(),
      },
    );

    Response response;
    try {
      if (method == "POST") {
        response = await dio.post(
          url + endpoint,
          data: payload,
          options: options,
        );
      } else {
        response = await dio.get(
          url + endpoint,
          queryParameters: {'category': 'linear', 'settleCoin': 'USDT'},
          options: options,
        );
      }

      final orders = (response.data['result']['list'] as List);

      state = List.generate(orders.length, (index) => ExecutedOrder.fromJson(orders[index]));
    } catch (e) {
      print('Error: $e');
    }
  }
}




final historyProvider = FutureProvider.autoDispose<HistoryNotifier>((ref) async {
  final openOrders = HistoryNotifier();
  await openOrders.fetchHistory();
  final timer = Timer.periodic(Duration(seconds: 3), (timer) async {
   ref.invalidateSelf();
  });
  ref.onDispose(() {
    timer.cancel();
  });

  return openOrders;
});
