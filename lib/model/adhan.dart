// To parse this JSON data, do
//
//     final adhan = adhanFromJson(jsonString);

import 'dart:convert';

class Adhan {
  Adhan({
    this.code,
    this.status,
    this.data,
  });

  final int code;
  final String status;
  final Data data;

  factory Adhan.fromRawJson(String str) => Adhan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Adhan.fromJson(Map<String, dynamic> json) => Adhan(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.timings,
    this.date,
    this.meta,
  });

  final Timings timings;
  final Date date;
  final Meta meta;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        timings: Timings.fromJson(json["timings"]),
        date: Date.fromJson(json["date"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "timings": timings.toJson(),
        "date": date.toJson(),
        "meta": meta.toJson(),
      };
}

class Date {
  Date({
    this.readable,
    this.timestamp,
    this.hijri,
    this.gregorian,
  });

  final String readable;
  final String timestamp;
  final Hijri hijri;
  final Gregorian gregorian;

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        readable: json["readable"],
        timestamp: json["timestamp"],
        hijri: Hijri.fromJson(json["hijri"]),
        gregorian: Gregorian.fromJson(json["gregorian"]),
      );

  Map<String, dynamic> toJson() => {
        "readable": readable,
        "timestamp": timestamp,
        "hijri": hijri.toJson(),
        "gregorian": gregorian.toJson(),
      };
}

class Gregorian {
  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  final String date;
  final String format;
  final String day;
  final GregorianWeekday weekday;
  final GregorianMonth month;
  final String year;
  final Designation designation;

  factory Gregorian.fromRawJson(String str) =>
      Gregorian.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: GregorianWeekday.fromJson(json["weekday"]),
        month: GregorianMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
      };
}

class Designation {
  Designation({
    this.abbreviated,
    this.expanded,
  });

  final String abbreviated;
  final String expanded;

  factory Designation.fromRawJson(String str) =>
      Designation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: json["abbreviated"],
        expanded: json["expanded"],
      );

  Map<String, dynamic> toJson() => {
        "abbreviated": abbreviated,
        "expanded": expanded,
      };
}

class GregorianMonth {
  GregorianMonth({
    this.number,
    this.en,
  });

  final int number;
  final String en;

  factory GregorianMonth.fromRawJson(String str) =>
      GregorianMonth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
        number: json["number"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
      };
}

class GregorianWeekday {
  GregorianWeekday({
    this.en,
  });

  final String en;

  factory GregorianWeekday.fromRawJson(String str) =>
      GregorianWeekday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      GregorianWeekday(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Hijri {
  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
  });

  final String date;
  final String format;
  final String day;
  final HijriWeekday weekday;
  final HijriMonth month;
  final String year;
  final Designation designation;
  final List<dynamic> holidays;

  factory Hijri.fromRawJson(String str) => Hijri.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: HijriWeekday.fromJson(json["weekday"]),
        month: HijriMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
        holidays: List<dynamic>.from(json["holidays"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
        "holidays": List<dynamic>.from(holidays.map((x) => x)),
      };
}

class HijriMonth {
  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  final int number;
  final String en;
  final String ar;

  factory HijriMonth.fromRawJson(String str) =>
      HijriMonth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
        number: json["number"],
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
        "ar": ar,
      };
}

class HijriWeekday {
  HijriWeekday({
    this.en,
    this.ar,
  });

  final String en;
  final String ar;

  factory HijriWeekday.fromRawJson(String str) =>
      HijriWeekday.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
      };
}

class Meta {
  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  final double latitude;
  final double longitude;
  final String timezone;
  final Method method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Timings offset;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        timezone: json["timezone"],
        method: Method.fromJson(json["method"]),
        latitudeAdjustmentMethod: json["latitudeAdjustmentMethod"],
        midnightMode: json["midnightMode"],
        school: json["school"],
        offset: Timings.fromJson(json["offset"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "timezone": timezone,
        "method": method.toJson(),
        "latitudeAdjustmentMethod": latitudeAdjustmentMethod,
        "midnightMode": midnightMode,
        "school": school,
        "offset": offset.toJson(),
      };
}

class Method {
  Method({
    this.id,
    this.name,
    this.params,
  });

  final int id;
  final String name;
  final Params params;

  factory Method.fromRawJson(String str) => Method.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json["id"],
        name: json["name"],
        params: Params.fromJson(json["params"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "params": params.toJson(),
      };
}

class Params {
  Params({
    this.fajr,
    this.isha,
  });

  final int fajr;
  final int isha;

  factory Params.fromRawJson(String str) => Params.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        fajr: json["Fajr"],
        isha: json["Isha"],
      );

  Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Isha": isha,
      };
}

class Timings {
  Timings({
    this.imsak,
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.sunset,
    this.isha,
    this.midnight,
  });

  final String imsak;
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String sunset;
  final String isha;
  final String midnight;

  factory Timings.fromRawJson(String str) => Timings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
        imsak: json["Imsak"],
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        maghrib: json["Maghrib"],
        sunset: json["Sunset"],
        isha: json["Isha"],
        midnight: json["Midnight"],
      );

  Map<String, dynamic> toJson() => {
        "Imsak": imsak,
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Maghrib": maghrib,
        "Sunset": sunset,
        "Isha": isha,
        "Midnight": midnight,
      };
}
