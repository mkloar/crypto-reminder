import 'dart:async';

import 'package:crypto_reminder/networking/api_response.dart';
import 'package:crypto_reminder/repository/crypto_repository.dart';
import 'package:crypto_reminder/models/cryptocurrency.dart';

class CryptoBloc {
  CryptoRepository _cryptoRepository;

  StreamController _cryptoListController;

  StreamSink<ApiResponse<List<CryptoCurrency>>> get cryptoCurrencyListSink =>
      _cryptoListController.sink;

  Stream<ApiResponse<List<CryptoCurrency>>> get cryptoCurrencyListStream =>
      _cryptoListController.stream;

  CryptoBloc() {
    _cryptoListController =
        StreamController<ApiResponse<List<CryptoCurrency>>>();
    _cryptoRepository = CryptoRepository();
    fetchCryptoList();
  }

  fetchCryptoList() async {
    cryptoCurrencyListSink.add(ApiResponse.loading('Fetching Crypto Data'));
    try {
      List<CryptoCurrency> cryptoCurrencies =
          await _cryptoRepository.fetchCryptoList();
      cryptoCurrencyListSink.add(ApiResponse.completed(cryptoCurrencies));
    } catch (e) {
      cryptoCurrencyListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _cryptoListController?.close();
  }
}
