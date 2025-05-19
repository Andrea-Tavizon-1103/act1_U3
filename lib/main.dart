import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: YosemiteSlider(),
  ));
}

class YosemiteSlider extends StatefulWidget {
  const YosemiteSlider({super.key});

  @override
  State<YosemiteSlider> createState() => _YosemiteSliderState();
}

class _YosemiteSliderState extends State<YosemiteSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> items = [
    {
      'image': 'https://raw.githubusercontent.com/Andrea-Tavizon-1103/apple_imagenes_app_flutter/refs/heads/main/apple11.jpg',
      'title': 'iPhone',
      'description':
          'Nuestra cámara Fusion de 48 MP más avanzada. Cámara teleobjetivo de 5x',
    },
    {
      'image': 'https://raw.githubusercontent.com/Andrea-Tavizon-1103/apple_imagenes_app_flutter/refs/heads/main/iphone34.jpg',
      'title': 'Pantalla iPhone',
      'description':
          'Cada iPhone viene con una cobertura de reparación de hardware ',
    },
    {
      'image': 'https://raw.githubusercontent.com/Andrea-Tavizon-1103/apple_imagenes_app_flutter/refs/heads/main/apple2.jpg',
      'title': 'Articulos de Distintos Colores',
      'description':
          'Aqui encontrara todos los articulos que necesitas a el color que desees',
    },
    {
      'image': 'https://raw.githubusercontent.com/Andrea-Tavizon-1103/apple_imagenes_app_flutter/refs/heads/main/apple3.jpg',
      'title': 'iPhone, AppleWatch, AirPods Pro',
      'description':
          'Todos los accesorios que necesitas en una sola app',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final bool active = index == _currentPage;

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Cambiado a Image.network para usar URLs
                  Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.white));
                    },
                  ),
                  Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

                  AnimatedPositioned(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    bottom: active ? 80 : 40,
                    left: 20,
                    right: 20,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 700),
                      opacity: active ? 1.0 : 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(5, (index) {
                              return const Icon(Icons.star, color: Colors.amber, size: 16);
                            }),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['description']!,
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: const Text('READ MORE', style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Text(
              '${_currentPage + 1}/${items.length}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: items.length,
              effect: WormEffect(
                dotColor: Colors.white38,
                activeDotColor: Colors.white,
                dotHeight: 8,
                dotWidth: 8,
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
