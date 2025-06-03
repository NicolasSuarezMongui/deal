// /lib/screens/product_detail_screen.dart

import 'package:deal/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Para el mapa
import 'package:provider/provider.dart';

import 'package:deal/models/producto.dart';
import 'package:deal/data/productos_database.dart';
import 'package:deal/widgets/product_card.dart';
import 'package:deal/services/cart_service.dart';
import 'package:deal/services/favorites_service.dart';
import 'package:deal/screens/product_list_screen.dart';
import 'package:deal/screens/cart_screen.dart';        // Pantalla del carrito
import 'package:deal/screens/map_screen.dart';         // Pantalla del mapa
import 'package:deal/widgets/rounded_app_bar.dart';    // Si tienes un AppBar personalizado
import 'package:deal/widgets/custom_bottom_nav_bar.dart'; // Si tienes un BottomNavigationBar personalizado


class ProductDetailScreen extends StatefulWidget {
  final Producto producto;

  const ProductDetailScreen({Key? key, required this.producto}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late List<Producto> _similares;
  late PageController _pageController;
  int _currentPage = 0;

  final double bottomNavBarHeight = 60.0;
  final Color colorPrincipal = const Color(0xFF0B132B);
  final Color colorSecundario = const Color(0xFF3A506B);

  @override
  void initState() {
    super.initState();
    // 1) Obtenemos productos similares (misma categoría, distinto código)
    _similares = ProductosDatabase()
        .obtenerProductosPorCategoriaGlobal(widget.producto.categoria)
        .where((p) => p.codigo != widget.producto.codigo)
        .toList();

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Agrega el producto actual al carrito y navega a CartScreen
  void _addToCartAndGotoCart() {
    final cartService = context.read<CartService>();
    cartService.addProduct(widget.producto);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CartScreen()),
    );
  }

  /// Agrega el producto actual al carrito y se queda en esta pantalla (sin navegar)
  void _addToCartStay() {
    final cartService = context.read<CartService>();
    cartService.addProduct(widget.producto);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Producto añadido al carrito'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  /// Añade o remueve de favoritos, y muestra un toast/snakbar
  void _toggleFavorite() {
    final favService = context.read<FavoritesService>();
    final esFavorito = favService.isFavorite(widget.producto);

    if (esFavorito) {
      favService.removeFavorite(widget.producto);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Eliminado de favoritos')),
      );
    } else {
      favService.addFavorite(widget.producto);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agregado a favoritos')),
      );
    }
    // ¡Ya no necesitas llamar a setState()!
  }

  /// Muestra un menú con "Agregar a favoritos" y "Ver en mapa"
  void _onMenuSelected(String opcion) {
    if (opcion == 'favorito') {
      _toggleFavorite();
    } else if (opcion == 'mapa') {
      // Navegar a MapScreen con la ubicación de los supermercados cercanos
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;
    final esFavorito = context.watch<FavoritesService>().isFavorite(producto);

    return Scaffold(
      // Si tienes tu propio RoundedAppBar, puedes usarlo. Aquí ponemos un AppBar transparente
      appBar: RoundedAppBar(title: producto.nombre,
        backgroundColor: Colors.transparent, // Fondo transparente
        buttonColor: Color(0xFF2885B6), // Color del botón de atrás
        textColor: Colors.white, // Color del texto del título
        showBackButton: true,
      ),

      body: Stack(
        children: [
          // 1) Fondo de la pantalla (puedes poner un color suave o nada)
          Container(color: Colors.white),

          // 2) Contenido scrollable
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // ===============================
                // 2a) Header ROJO con corazón, nombre y 3 puntos
                // ===============================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        // Ícono Corazón
                        GestureDetector(
                          onTap: _toggleFavorite,
                          child: Icon(
                            // Ahora el color y el icono dependen directamente de "esFavorito"
                            esFavorito ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            producto.nombre,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onSelected: _onMenuSelected,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'favorito',
                              child: Text(esFavorito
                                  ? 'Quitar de favoritos'
                                  : 'Agregar a favoritos'),
                            ),
                            const PopupMenuItem(
                              value: 'mapa',
                              child: Text('Ver en mapa'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ===============================
                // 2b) Carrusel de imágenes (PageView)
                // ===============================
                SizedBox(
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: 1 /* Aquí podrías usar producto.images.length si hay varias */,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          // Si tu producto tuviera una lista de imágenes:
                          // final imageUrl = producto.images[index];
                          final imageUrl = producto.imageUrl ?? 'assets/logo_${producto.supermercadoId}.png';
                          return Center(
                            child: Image.asset(
                              imageUrl,
                              width: 180,
                              height: 250,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),

                      // Flecha izquierda
                      if (_currentPage > 0)
                        Positioned(
                          left: 8,
                          child: GestureDetector(
                            onTap: () {
                              if (_currentPage > 0) {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black26,
                              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                            ),
                          ),
                        ),

                      // Flecha derecha (si hubiera más de una imagen)
                      // Positioned(
                      //   right: 8,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       if (_currentPage < producto.images.length - 1) {
                      //         _pageController.nextPage(
                      //           duration: Duration(milliseconds: 300),
                      //           curve: Curves.easeInOut,
                      //         );
                      //       }
                      //     },
                      //     child: CircleAvatar(
                      //       backgroundColor: Colors.black26,
                      //       child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ===============================
                // 2c) Precio + ícono supermercado + peso/medida
                // ===============================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // ahora centran verticalmente
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Peso / descripción pequeña
                            Text(
                              producto.codigo,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Fila: Precio grande + icono supermercado
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ ${producto.precioFinal.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3A506B),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Icono del supermercado (logo)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/logo_${producto.supermercadoId}.png',
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) {
                                      return const Icon(Icons.store, size: 32, color: Colors.grey);
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Rating y slogan/Invímia
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Invímia | Te Acompaña',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          // Botón “Lista” (lápiz). Agrega al carrito y va al carrito
                          GestureDetector(
                            onTap: _addToCartAndGotoCart,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A506B),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 28),
                            ),
                          ),

                          const SizedBox(width: 8), // separación pequeña entre botones

                          // Botón “Carrito” (carrito de compras). Igual comportamiento
                          GestureDetector(
                            onTap: _addToCartAndGotoCart,
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A506B),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ===============================
                // 2e) Sección “Similares”
                // ===============================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Similares',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _similares.length,
                    itemBuilder: (context, index) {
                      final sim = _similares[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            // Al tocar, navegamos a otro ProductDetailScreen de ese producto
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(producto: sim),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  sim.imageUrl ?? 'assets/logo_${producto.supermercadoId}.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) {
                                    return Icon(Icons.broken_image, size: 80, color: Colors.grey[400]);
                                  },
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  sim.nombre,
                                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1)
    );
  }

}
