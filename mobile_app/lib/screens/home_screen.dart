import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app/services/api_service.dart';
import 'package:mobile_app/widgets/shop_details_modal.dart'; // Assurez-vous que le chemin est correct

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiService = ApiService(baseUrl: 'http://localhost:3000');

  bool isModalOpen = false; // État pour contrôler l'affichage de la modale
  late dynamic selectedShop; // Stocke les détails du shop sélectionné

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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final markers = snapshot.data!.map((shop) {
              return Marker(
                point: LatLng(shop['gps']['coordinates'][0], shop['gps']['coordinates'][1]),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    setState(() {
                      isModalOpen = true;
                      selectedShop = shop;
                    });
                  },
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
              );
            }).toList();

            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: LatLng(48.8566, 2.3522),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(markers: markers),
                  ],
                ),
                // Modale
                if (isModalOpen)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isModalOpen = false;
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ShopDetailsModal(shopDetails: selectedShop),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        isModalOpen = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
