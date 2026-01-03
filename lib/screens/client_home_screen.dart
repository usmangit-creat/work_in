import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Real Map
import 'package:latlong2/latlong.dart'; // Coordinates

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  // --- STATE VARIABLES ---
  String _selectedCategory = 'Plumber';

  // --- CONSTANTS ---
  final Color _primaryColor = const Color(0xFF2C43A8);
  final Color _accentColor = const Color(0xFFFF6B00);

  // Data List
  final List<String> _categories = [
    'Plumber', 'Electrician', 'Maid', 'Cleaner', 'Painter', 'Carpenter', 'AC Repair'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ============================================================
          // LAYER 1: REAL MAP (Background)
          // ============================================================
          _buildMapLayer(),

          // ============================================================
          // LAYER 2: BOTTOM SHEET (Search & Categories)
          // ============================================================
          _buildBottomSheet(),

          // ============================================================
          // LAYER 3: FLOATING BUTTONS (Top Layer)
          // ============================================================
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  // ============================================================
  // WIDGET: MAP LAYER
  // ============================================================
  Widget _buildMapLayer() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(31.5204, 74.3587), // Lahore
        initialZoom: 15.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.work_in',
        ),
        MarkerLayer(
          markers: [
            // --- Workers (Orange Pins) ---
            _buildPinMarker(const LatLng(31.5220, 74.3560)),
            _buildPinMarker(const LatLng(31.5180, 74.3600)),
            _buildPinMarker(const LatLng(31.5250, 74.3650)),

            // --- Text Labels (Map Locations) ---
            Marker(
              point: const LatLng(31.5240, 74.3550),
              width: 100, height: 30,
              child: const Text("UNION", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ),
            Marker(
              point: const LatLng(31.5190, 74.3620),
              width: 100, height: 30,
              child: const Text("LOWER MALL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            ),

            // --- User Location (Blue Dot) ---
            Marker(
              point: const LatLng(31.5204, 74.3587),
              width: 25, height: 25,
              child: Container(
                decoration: BoxDecoration(
                  color: _primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
              ),
            ),

            // --- Worker Details Tooltip ---
            Marker(
              point: const LatLng(31.5230, 74.3590),
              width: 200, height: 120,
              alignment: Alignment.topCenter,
              child: _buildWorkerTooltip(),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // WIDGET: BOTTOM SHEET
  // ============================================================
  Widget _buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search or choose category',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // --- Search Bar ---
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 3)),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for category',
                  hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Categories (Chips) ---
            Wrap(
              spacing: 10, runSpacing: 10,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? _accentColor : const Color(0xFFEBEBEB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),

            // Load More Link
            Text(
              'Load more...',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: _accentColor,
                decoration: TextDecoration.underline,
                decorationColor: _accentColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),

            // --- Find Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: const Text(
                  'Find a worker',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WIDGET: FLOATING BUTTONS
  // ============================================================
  Widget _buildFloatingButtons() {
    return Stack(
      children: [
        // Menu Button (Top Left)
        Positioned(
          top: 50, left: 20,
          child: Container(
            height: 50, width: 50,
            decoration: BoxDecoration(
              color: _primaryColor,
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),

        // Direction Button (Above Bottom Sheet)
        Positioned(
          bottom: 430, // Adjusted as per your request
          right: 20,
          child: Container(
            height: 55, width: 55,
            decoration: BoxDecoration(
              color: _primaryColor,
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
            ),
            child: const Icon(Icons.near_me, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HELPERS: MARKERS
  // ============================================================

  Marker _buildPinMarker(LatLng point) {
    return Marker(
      point: point,
      width: 40, height: 40,
      child: Icon(Icons.location_on, color: _accentColor, size: 40),
    );
  }

  Widget _buildWorkerTooltip() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 35, width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300,
                  image: const DecorationImage(image: AssetImage('assets/role_worker.png'), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("M. Ahmadi", style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.bold)),
                  Row(children: [Text("4.5", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), Icon(Icons.star, color: Colors.amber, size: 10)]),
                  Text("Electrician", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -6),
          child: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 30),
        ),
      ],
    );
  }
}