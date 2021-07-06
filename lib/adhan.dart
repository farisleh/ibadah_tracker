// To parse this JSON data, do
//
//     final results = resultsFromJson(jsonString);

import 'dart:convert';

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));

String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    this.code,
    this.status,
    this.results,
  });

  int code;
  String status;
  ResultsClass results;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        code: json["code"],
        status: json["status"],
        results: ResultsClass.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "results": results.toJson(),
      };
}

class ResultsClass {
  ResultsClass({
    this.datetime,
    this.location,
    this.settings,
  });

  List<Datetime> datetime;
  Location location;
  Settings settings;

  factory ResultsClass.fromJson(Map<String, dynamic> json) => ResultsClass(
        datetime: List<Datetime>.from(
            json["datetime"].map((x) => Datetime.fromJson(x))),
        location: Location.fromJson(json["location"]),
        settings: Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "datetime": List<dynamic>.from(datetime.map((x) => x.toJson())),
        "location": location.toJson(),
        "settings": settings.toJson(),
      };
}

class Datetime {
  Datetime({
    this.imsak,
    this.sunrise,
    this.fajr,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.midnight,
  });

  String imsak;
  String sunrise;
  String fajr;
  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  String midnight;

  factory Datetime.fromJson(Map<String, dynamic> json) => Datetime(
        imsak: json["Imsak"].toString(),
        sunrise: json["Sunrise"].toString(),
        fajr: json["Fajr"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        midnight: json["Midnight"],
      );

  Map<String, dynamic> toJson() => {
        "Imsak": imsak,
        "Sunrise": sunrise,
        "Fajr": fajr,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Midnight": midnight,
      };
}

class Date {
  Date({
    this.timestamp,
    this.gregorian,
    this.hijri,
  });

  int timestamp;
  DateTime gregorian;
  DateTime hijri;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        timestamp: json["timestamp"],
        gregorian: DateTime.parse(json["gregorian"]),
        hijri: DateTime.parse(json["hijri"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "gregorian":
            "${gregorian.year.toString().padLeft(4, '0')}-${gregorian.month.toString().padLeft(2, '0')}-${gregorian.day.toString().padLeft(2, '0')}",
        "hijri":
            "${hijri.year.toString().padLeft(4, '0')}-${hijri.month.toString().padLeft(2, '0')}-${hijri.day.toString().padLeft(2, '0')}",
      };
}

class Location {
  Location({
    this.latitude,
    this.longitude,
    this.elevation,
    this.city,
    this.country,
    this.countryCode,
    this.timezone,
    this.localOffset,
  });

  double latitude;
  double longitude;
  double elevation;
  String city;
  String country;
  String countryCode;
  String timezone;
  double localOffset;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        elevation: json["elevation"].toDouble(),
        city: json["city"],
        country: json["country"],
        countryCode: json["country_code"],
        timezone: json["timezone"],
        localOffset: json["local_offset"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "elevation": elevation,
        "city": city,
        "country": country,
        "country_code": countryCode,
        "timezone": timezone,
        "local_offset": localOffset,
      };
}

class Settings {
  Settings({
    this.timeformat,
    this.school,
    this.juristic,
    this.highlat,
    this.fajrAngle,
    this.ishaAngle,
  });

  String timeformat;
  String school;
  String juristic;
  String highlat;
  double fajrAngle;
  double ishaAngle;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        timeformat: json["timeformat"],
        school: json["school"],
        juristic: json["juristic"],
        highlat: json["highlat"],
        fajrAngle: json["fajr_angle"].toDouble(),
        ishaAngle: json["isha_angle"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "timeformat": timeformat,
        "school": school,
        "juristic": juristic,
        "highlat": highlat,
        "fajr_angle": fajrAngle,
        "isha_angle": ishaAngle,
      };
}
