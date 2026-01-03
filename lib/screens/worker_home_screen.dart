import 'package:flutter/material.dart';
// import 'worker_dashboard.dart'; // Jab wo file ban jaye to uncomment karein

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  // --- 1. Master Data List ---
  final List<Map<String, String>> _allServices = [
    {'title': 'Plumber', 'image': 'assets/Plumber.jpg'},
    {'title': 'Electrician', 'image': 'assets/Electrician.jpg'},
    {'title': 'Cleaner', 'image': 'assets/Cleaner.jpg'},
    {'title': 'Maid', 'image': 'assets/Maid.jpg'},
    {'title': 'Carpenters', 'image': 'assets/Caepenter.jpg'},
    {'title': 'Painters', 'image': 'assets/Painter.jpg'},
    {'title': 'AC Repair', 'image': 'assets/AC repair.jpg'},
    {'title': 'Handyman Tasks', 'image': 'assets/Handyman.jpg'},
    {'title': 'Appliance Service', 'image': 'assets/Appliance service.jpg'},
    {'title': 'Pest Control', 'image': 'assets/Pes control.jpg'},
  ];

  // --- 2. Filtered List ---
  List<Map<String, String>> _foundServices = [];

  // --- Constants ---
  final Color _primaryColor = const Color(0xFF2C43A8);

  @override
  void initState() {
    _foundServices = _allServices;
    super.initState();
  }

  // --- 3. Search Logic ---
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allServices;
    } else {
      results = _allServices
          .where((service) =>
          service["title"]!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundServices = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // [UPDATED] Latest way to dismiss keyboard in Flutter
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ========================================================
              // HEADER SECTION
              // ========================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'What type of work you do',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Subtitle
                    const Text(
                      'Search or select from the list below',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // --- Search Bar ---
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        style: const TextStyle(fontFamily: 'Poppins'),
                        decoration: const InputDecoration(
                          hintText: 'Search service...',
                          hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ========================================================
              // GRID LIST SECTION
              // ========================================================
              Expanded(
                child: _foundServices.isNotEmpty
                    ? GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.72, // Card Size Ratio
                  ),
                  itemCount: _foundServices.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      title: _foundServices[index]['title']!,
                      imagePath: _foundServices[index]['image']!,
                      primaryColor: _primaryColor,
                      onTap: () {
                        // --- NAVIGATION LOGIC ---
                        print("Selected: ${_foundServices[index]['title']}");

                        // Future Navigation:
                        /*
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const WorkerDashboard()),
                                (route) => false,
                              );
                              */
                      },
                    );
                  },
                )
                    : const Center(
                  child: Text("No service found", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// EXTRACTED WIDGET: ServiceCard
// ============================================================
class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color primaryColor;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image Area (Top) ---
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                cacheWidth: 400, // Optimize Memory

                // Smooth Fade-In Animation
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },

                // Error Handling
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.image_not_supported_outlined, color: Colors.grey)),
              ),
            ),
          ),

          // --- Content Area (Bottom) ---
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Select Button
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, // 'primary' is deprecated, used 'backgroundColor'
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Select',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
}