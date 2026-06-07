class Settings {
  static final Settings _instance = Settings._internal();

  factory Settings() {
    return _instance;
  }

  Settings._internal();
}

void main() {
  var settings1 = Settings();
  var settings2 = Settings();

  print(identical(settings1, settings2)); 
}

