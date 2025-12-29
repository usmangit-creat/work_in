import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  String _selectedCategory = 'Plumber';
  final List<String> _categories = [
    'Plumber', 'Electrician', 'Maid', 'Cleaner', 'Painter', 'Carpenter', 'AC Repair'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. Background Map (Dummy) ---
          Container(
            color: const Color(0xFFE5E5E5),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // Roads
                Positioned(top: 100, left: 50, child: _buildMapRoad()),
                Positioned(top: 300, right: 80, child: _buildMapRoad(angle: 1.57)),
                // Pins
                const Positioned(top: 150, left: 40, child: Icon(Icons.location_on, color: Color(0xFFFF6B00), size: 40)),
                const Positioned(top: 350, left: 80, child: Icon(Icons.location_on, color: Color(0xFFFF6B00), size: 40)),
                const Positioned(top: 520, left: 180, child: Icon(Icons.location_on, color: Color(0xFFFF6B00), size: 40)),
                // User Location
                Center(
                  child: Container(
                    height: 20, width: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
                // Worker Info Card
                Positioned(top: 180, right: 20, child: _buildWorkerCard()),
              ],
            ),
          ),

          // --- 2. Top Menu Button ---
          Positioned(
            top: 50, left: 20,
            child: CircleAvatar(
              backgroundColor: const Color(0xFF2C43A8),
              child: IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
            ),
          ),

          // --- 3. Bottom Sheet (Search & Categories) ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                  const Text('Search or choose category', style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12)),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for category',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none, contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Categories
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFF6B00) : const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(cat, style: TextStyle(fontFamily: 'Poppins', color: isSelected ? Colors.white : Colors.black, fontSize: 12)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C43A8), padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text('Find a worker', style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapRoad({double angle = 0}) => Transform.rotate(angle: angle, child: Container(height: 600, width: 20, color: Colors.white));

  Widget _buildWorkerCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
      child: Row(children: [
        Container(height: 40, width: 40, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey, image: const DecorationImage(image: AssetImage('assets/role_worker.png')))), // Make sure asset exists or remove image
        const SizedBox(width: 8),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("M. Ahmadi", style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.bold)),
          Text("Electrician", style: TextStyle(fontFamily: 'Poppins', fontSize: 10, color: Colors.grey)),
        ]),
      ]),
    );
  }
}