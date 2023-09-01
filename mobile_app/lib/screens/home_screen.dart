import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app/services/api_service.dart'; // Assurez-vous de remplacer par le chemin correct vers api_service.dart

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiService = ApiService(baseUrl: 'http://localhost:3000'); // Remplacez par l'URL de votre backend

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchShops(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Affiche un indicateur de chargement pendant le chargement des données.
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Convertit les données en marqueurs pour la carte.
            final markers = snapshot.data!.map((shop) {
              return Marker(
                point: LatLng(shop['gps']['coordinates'][0], shop['gps']['coordinates'][1]),
                builder: (ctx) => Icon(Icons.location_on, color: Colors.red),
              );
            }).toList();

            return FlutterMap(
              options: MapOptions(
                center: LatLng(48.8566, 2.3522), // Coordonnées de Paris
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(markers: markers),
              ],
            );
          }
        },
      ),
    );
  }
}
