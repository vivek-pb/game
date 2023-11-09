class TestModel {
  TestModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
    this.sparklineIn7d,
    this.priceChangePercentage7dInCurrency,
  });

  TestModel.fromJson(dynamic json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    fullyDilutedValuation = json['fully_diluted_valuation'];
    totalVolume = json['total_volume'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    marketCapChange24h = json['market_cap_change_24h'];
    marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    circulatingSupply = json['circulating_supply'];
    totalSupply = json['total_supply'];
    maxSupply = json['max_supply'];
    ath = json['ath'];
    athChangePercentage = json['ath_change_percentage'];
    athDate = json['ath_date'];
    atl = json['atl'];
    atlChangePercentage = json['atl_change_percentage'];
    atlDate = json['atl_date'];
    roi = json['roi'];
    lastUpdated = json['last_updated'];
    sparklineIn7d = json['sparkline_in_7d'] != null
        ? SparklineIn7d.fromJson(json['sparkline_in_7d'])
        : null;
    priceChangePercentage7dInCurrency =
        json['price_change_percentage_7d_in_currency'];
  }
  String? id;
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  num? marketCap;
  num? marketCapRank;
  num? fullyDilutedValuation;
  num? totalVolume;
  num? high24h;
  num? low24h;
  num? priceChange24h;
  num? priceChangePercentage24h;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? circulatingSupply;
  num? totalSupply;
  num? maxSupply;
  num? ath;
  num? athChangePercentage;
  String? athDate;
  num? atl;
  num? atlChangePercentage;
  String? atlDate;
  dynamic roi;
  String? lastUpdated;
  SparklineIn7d? sparklineIn7d;
  num? priceChangePercentage7dInCurrency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symbol'] = symbol;
    map['name'] = name;
    map['image'] = image;
    map['current_price'] = currentPrice;
    map['market_cap'] = marketCap;
    map['market_cap_rank'] = marketCapRank;
    map['fully_diluted_valuation'] = fullyDilutedValuation;
    map['total_volume'] = totalVolume;
    map['high_24h'] = high24h;
    map['low_24h'] = low24h;
    map['price_change_24h'] = priceChange24h;
    map['price_change_percentage_24h'] = priceChangePercentage24h;
    map['market_cap_change_24h'] = marketCapChange24h;
    map['market_cap_change_percentage_24h'] = marketCapChangePercentage24h;
    map['circulating_supply'] = circulatingSupply;
    map['total_supply'] = totalSupply;
    map['max_supply'] = maxSupply;
    map['ath'] = ath;
    map['ath_change_percentage'] = athChangePercentage;
    map['ath_date'] = athDate;
    map['atl'] = atl;
    map['atl_change_percentage'] = atlChangePercentage;
    map['atl_date'] = atlDate;
    map['roi'] = roi;
    map['last_updated'] = lastUpdated;
    if (sparklineIn7d != null) {
      map['sparkline_in_7d'] = sparklineIn7d?.toJson();
    }
    map['price_change_percentage_7d_in_currency'] =
        priceChangePercentage7dInCurrency;
    return map;
  }
}

class SparklineIn7d {
  SparklineIn7d({
    this.price,
  });

  SparklineIn7d.fromJson(dynamic json) {
    price = json['price'] != null ? json['price'].cast<num>() : [];
  }
  List<num>? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    return map;
  }
}

abstract class Parse {
  parse(dynamic response) {
    if (response.runtimeType == List) {
      return List<TestModel>.from(response.map((e) => TestModel.fromJson(e)));
    }
    return TestModel.fromJson(response);
  }
}
