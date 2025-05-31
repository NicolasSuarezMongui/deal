import 'package:flutter/material.dart';
import 'dart:async';

class Promocion {
  final String title;
  final String imageUrl;

  Promocion({required this.title, required this.imageUrl});
}

class PromocionesCarrusel extends StatefulWidget {
  @override
  _PromocionesCarruselState createState() => _PromocionesCarruselState();
}

class _PromocionesCarruselState extends State<PromocionesCarrusel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Promocion> promociones = [
    Promocion(title: 'Promoción 1', imageUrl: 'assets/promo1.png'),
    Promocion(title: 'Promoción 2', imageUrl: 'assets/promo2.png'),
    Promocion(title: 'Promoción 3', imageUrl: 'assets/promo3.png'),
    Promocion(title: 'Promoción 4', imageUrl: 'assets/promo4.png'),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < promociones.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 116,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: promociones.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 367,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      ClipRect(
                        child: Image.asset(
                          promociones[index].imageUrl,
                          width: 367,
                          height: 116,
                          fit: BoxFit.cover,
                        ),
                      ),              
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}