// // ignore_for_file: import_of_legacy_library_into_null_safe

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geodesy/geodesy.dart' show Geodesy;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong2/latlong.dart' as lat2;
// import 'package:maps_toolkit/maps_toolkit.dart' as mtk;
// import 'package:transit_ride_app/utils/helpers/lat_lng_extensions.dart';
// import 'package:mbl_mtm_link_member/theme/app_colors.dart';
// import 'package:transit_ride_app/utils/helpers/kandinsky.dart';

// class MapHelpers {
//   static Geodesy _geodesy = Geodesy();
//   static List<mtk.LatLng> _projectedPath = <mtk.LatLng>[];

//   static addProjectedPoint(PointLatLng point) {
//     mtk.LatLng l = mtk.LatLng(point.latitude, point.longitude);
//     _projectedPath.add(l);
//   }

//   static num getDistanceBetweenPoints({
//     required LatLng start,
//     required LatLng end,
//   }) {
//     lat2.LatLng s = start.toLat2();
//     lat2.LatLng e = end.toLat2();

//     num distanceBetweenPoints = _geodesy.distanceBetweenTwoGeoPoints(
//       s,
//       e,
//     );

//     return distanceBetweenPoints;
//   }

//   static num getDistanceToLastPoint(LatLng currentLocation) {
//     LatLng end = _projectedPath.last.toLatLng();
//     num distance = getDistanceBetweenPoints(start: currentLocation, end: end);

//     return distance;
//   }

//   static LatLng getDestinationPointByDistanceAndBearing({
//     required LatLng currentPoint,
//     required double distanceTravelled,
//     required double bearing,
//   }) {
//     lat2.LatLng destinationPoint =
//         _geodesy.destinationPointByDistanceAndBearing(
//       currentPoint.toLat2(),
//       distanceTravelled,
//       bearing,
//     );

//     return destinationPoint.toLatLng();
//   }

//   static bool isLocationOnPath(LatLng location) {
//     if (mtk.PolygonUtil.isLocationOnPath(
//       location.toMtk(),
//       _projectedPath,
//       false,
//       tolerance: 15.0,
//     )) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static LatLng? findClosestPoint(LatLng location, double distanceTravelled) {
//     LatLng? closestPoint;
//     List<lat2.LatLng> pp = <lat2.LatLng>[];

//     _projectedPath.forEach((point) {
//       pp.add(lat2.LatLng(point.latitude, point.longitude));
//     });

//     var pointsInRange = _geodesy.pointsInRange(
//       location.toLat2(),
//       pp,
//       distanceTravelled * 2,
//     );

//     num closestDistance = 99999999;
//     pointsInRange.forEach((point) {
//       lat2.LatLng current = location.toLat2();
//       lat2.LatLng dest = lat2.LatLng(point.latitude, point.longitude);

//       var d = _geodesy.distanceBetweenTwoGeoPoints(dest, current);
//       if (d < closestDistance) {
//         closestDistance = d;
//         closestPoint = point.toLatLng();
//       }
//     });

//     return closestPoint;
//   }

//   static double? getBearingBetweenPoints(LatLng currentPoint) {
//     num? bearing;

//     var currentPointIndex = _projectedPath.indexWhere((p) =>
//         p.latitude == currentPoint.latitude &&
//         p.longitude == currentPoint.longitude);

//     var nextPoint = _projectedPath[currentPointIndex + 1];

//     bearing = _geodesy.bearingBetweenTwoGeoPoints(
//         currentPoint.toLat2(), nextPoint.toLatLng().toLat2());

//     return double.tryParse(bearing.toString());
//   }

//   static List<Color> getGradientColorsForPath(int numberOfColors) {
//     List<num> startingColor = [
//       kMTMOrangeRouteStart.red,
//       kMTMOrangeRouteStart.green,
//       kMTMOrangeRouteStart.blue,
//     ];

//     List<num> endingColor = [
//       kMTMGreenRouteEnd.red,
//       kMTMGreenRouteEnd.green,
//       kMTMGreenRouteEnd.blue,
//     ];

//     var colors = Kandinsky.multiGradient(
//       numberOfColors,
//       [
//         startingColor,
//         endingColor,
//       ],
//     );

//     return colors
//         .map((List<num> color) => Color.fromRGBO(
//             color[0].round(), color[1].round(), color[2].round(), 1))
//         .toList();
//   }

// }
