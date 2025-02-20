import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;

  final List<Map<String, dynamic>> waterOptions = [
    {'title': 'Hot Water', 'color': Colors.redAccent},
    {'title': 'Cold Water', 'color': Colors.blueAccent},
    {'title': 'Normal Water', 'color': Colors.greenAccent},
    {'title': 'Ice Cubes', 'color': Colors.cyanAccent},
  ];

  @override
  Widget build(BuildContext context) {

    // final user = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 600,
              child: PageView.builder(
                controller: _pageController,
                itemCount: waterOptions.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: waterOptions[index]['color'],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        waterOptions[index]['title'],
                        style: GoogleFonts.acme(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              waterOptions.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: _currentIndex == index ? 12 : 8,
                height: _currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.black : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          BottomNavigationBar(items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
            
          ],
          ),
        ],
      ),
    );
  }
}
