import 'package:currency_converter/models/ratesmodel.dart';
import 'package:currency_converter/utils/key.dart';
import 'package:http/http.dart' as http;

Future<RatesModel> fetchrates() async {
  var response = await http.get(
    Uri.parse('https://openexchangerates.org/api/latest.json?base=USD&app_id=$key'),
  );

  if (response.statusCode == 200) {
    return ratesModelFromJson(response.body);
  } else {
    throw Exception('Failed to load exchange rates');
  }
}
