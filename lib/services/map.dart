import 'package:url_launcher/url_launcher.dart';


class MapUtils {

  MapUtils._();
//double latitude, double longitude
  static Future<void> openMap() async {
    String googleUrl = 'https://www.google.com/maps/search/hospitals nearby';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openMappharmacy(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/pharmacy nearby';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

}