import 'package:crypto_reminder/networking/api_helper.dart';
import 'package:crypto_reminder/models/cryptocurrency.dart';

class CryptoRepository {
  ApiBaseHelper _helper = ApiBaseHelper('https://api.blockchain.com/v3');

  Future<List<CryptoCurrency>> fetchCryptoList() async {
    final List response = await _helper.get('/exchange/tickers');
    return CryptoCurrencyResponse.fromJsonList(response).results;
  }
}