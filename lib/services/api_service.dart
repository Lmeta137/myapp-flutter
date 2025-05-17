import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // добавлен для debugPrint
import '../models/exchange_rate.dart';

class ApiService {
  static Future<ExchangeRate?> getRate(String from, String to) async {
    final url = Uri.parse('https://open.er-api.com/v6/latest/$from');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['result'] == 'success') {
          final rate = data['rates'][to];
          final date = data['time_last_update_utc'];
          return ExchangeRate(
            from: from,
            to: to,
            rate: rate.toDouble(),
            date: date,
          );
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}
