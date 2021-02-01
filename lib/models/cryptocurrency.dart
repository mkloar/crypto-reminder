class CryptoCurrencyResponse {
  int totalResults;
  List<CryptoCurrency> results;
  CryptoCurrencyResponse({this.totalResults, this.results});
  CryptoCurrencyResponse.fromJsonList(List cryptoList) {
    if (cryptoList != null) {
      results = cryptoList.map((crypto) => CryptoCurrency.fromJson(crypto)).toList();
    }
  }
}

class CryptoCurrency {
  final String symbol;
  final double price24h;
  final double volume24h;
  final double lastPrice;

  CryptoCurrency({this.symbol, this.price24h, this.volume24h, this.lastPrice});

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    // TODO: Should we split symbol: EUR-BTC to something?
    return CryptoCurrency(
        symbol: json['symbol'],
        price24h: json['price_24h'],
        volume24h: json['volume_24h'],
        lastPrice: json['last_trade_price']
    );
  }
}