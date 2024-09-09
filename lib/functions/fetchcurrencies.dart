import 'package:currency_converter/models/allcurrencies.dart';
import 'package:currency_converter/utils/key.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchcurrencies() async {
  var response = await http.get(
    Uri.parse('https://openexchangerates.org/api/currencies.json?app_id=$key'),
  );
  
  if (response.statusCode == 200) {
    return allCurrenciesFromJson(response.body);
  } else {
    throw Exception('Failed to load currencies');
  }
}
