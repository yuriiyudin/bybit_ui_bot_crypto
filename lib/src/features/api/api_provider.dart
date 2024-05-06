//

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:terminal_octopus/src/constants/api_keys.dart';
import 'package:terminal_octopus/src/models/open_order.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final bybitApiProvider = Provider<BybitApi>((ref) => BybitApi());

class BybitApi {
  final _wsUrl = Uri.parse('wss://stream.bybit.com/v5/private');
  final String url = "https://api.bybit.com";
  static int _expires = ((DateTime.now().millisecondsSinceEpoch + 1) * 1000);
  final int recvWindow = 5000;

  final signature = Hmac(sha256, utf8.encode(apiSecret))
      .convert(
        utf8.encode("GET/realtime$_expires"),
      )
      .toString();

  Stream<dynamic> fetchOpenOrderWs() {
    final channel = WebSocketChannel.connect(_wsUrl);
    final controller = StreamController<dynamic>();

    // Authenticate with API.
    channel.sink.add(jsonEncode({
      "op": "auth",
      "args": [apiKey, expires, signature]
    }));

    // Подписка на канал данных "order"
    channel.sink.add(jsonEncode({
      "op": "subscribe",
      "args": ["order"]
    }));

    channel.stream.listen((message) {
      print(message);
      controller.add(message);
    });

    // Закрытие соединения
    // channel.sink.close();
    return controller.stream;
  }

  Future<List<OpenOrder>> fetchOpenOrdersRest() async {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final hmacSha256 = Hmac(sha256, const Utf8Encoder().convert(apiSecret));
    String payload = 'category=linear&settleCoin=USDT'; //
    final String paramStr = "$timestamp$apiKey$recvWindow$payload";
    final Digest sign = hmacSha256.convert(utf8.encode(paramStr));

    // String encoder =  base64Encode(hash);

    Dio dio = Dio();

    String endpoint = "/v5/order/realtime"; // Замените на ваш реальный путь к API
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
      print(orders);

      return List.generate(orders.length, (index) => OpenOrder.fromJson(orders[index]));
    } catch (e) {}
    return [];
  }
}
