class Weather {
  final double temp;
  final double humidity;
  final double low;
  final double high;
  final String description;

  Weather({required this.temp, required this.humidity, required this.low, required this.high, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}