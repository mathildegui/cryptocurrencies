class Currency {
  final String id;
  final String name;
  final String symbol;
  final String rank;
  final String priceUsd;
  final String priceBtc;
  final String volume24Usd;

  Currency({this.id, this.name, this.symbol, this.rank,
    this.priceUsd, this.priceBtc, this.volume24Usd});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return new Currency(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      rank: json['rank'],
      priceUsd: json['price_usd'],
      priceBtc: json['price_btc'],
      volume24Usd: json['24h_volume_usd'],
    );
  }
}