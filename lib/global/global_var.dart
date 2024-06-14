import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;

String googleMapKey = "AIzaSyCxevwjA9FGdoBGXE4sm3o2wCj9H3Y-Wbw";
String serverKeyFCM = "key=AAAAWrsD34w:APA91bHYYtRvIOMc5VuKBBWJmwgIGwUFrjeclWOwyBfBMaYbQ_ZFRmyZ9bDhmMy4CP1yq4VkbpczU3yIPkCGSpgc3KNuayfIwVUhVoCLM87z5YpkBZTh6YP0PfchVcVQqUmWqgJO1kVD";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);


