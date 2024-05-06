import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_octopus/src/constants/api_keys.dart';
import 'package:terminal_octopus/src/features/api/api_provider.dart';
import 'package:terminal_octopus/src/models/open_order.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class HistoryOrderNotifier extends StateNotifier<List<OpenOrder>> {
  HistoryOrderNotifier() : super([]);

  Future<void> fetchOpenOrdersRest() async {
    final String url = "https://api.bybit.com";
    // final String url = "https://api-demo.bybit.com";
    int _expires = ((DateTime.now().millisecondsSinceEpoch + 1) * 1000);
    final int recvWindow = 5000;

    final signature = Hmac(sha256, utf8.encode(apiSecret))
        .convert(
          utf8.encode("GET/realtime$_expires"),
        )
        .toString();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final hmacSha256 = Hmac(sha256, const Utf8Encoder().convert(apiSecret));
    String payload = 'category=linear&settleCoin=USDT'; //
    final String paramStr = "$timestamp$apiKey$recvWindow$payload";
    final Digest sign = hmacSha256.convert(utf8.encode(paramStr));

    // String encoder =  base64Encode(hash);

    Dio dio = Dio();

    String endpoint = "/v5/position/list"; // Замените на ваш реальный путь к API
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
  

      state = List.generate(orders.length, (index) => OpenOrder.fromJson(orders[index]));
    } catch (e) {}
  }
}

final openOrdersProvider = FutureProvider.autoDispose<HistoryOrderNotifier>((ref) async {
  final openOrders = HistoryOrderNotifier();
  await openOrders.fetchOpenOrdersRest();
  final timer = Timer.periodic(Duration(seconds: 3), (timer) async {
   ref.invalidateSelf();
  });
  ref.onDispose(() {
    timer.cancel();
  });

  return openOrders;
});
