// /lib/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deal/services/favorites_service.dart';
import 'package:deal/models/producto.dart';
import 'package:deal/widgets/searchbar.dart';
import 'package:deal/widgets/custom_bottom_nav_bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la lista de productos favoritos del servicio
    final favService = context.watch<FavoritesService>();
    final List<Producto> productos = favService.favorites;

    // Obtenemos el set de supermercadoId únicos para mostrar sus logos
    final Set<String> supermercadoIds = productos
        .map((p) => p.supermercadoId)
        .toSet();

    return Scaffold(
      // ===========================
      // APPBAR PERSONALIZADO: corazón + Favoritos
      // ===========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.favorite, color: Color(0xFF3A506B)),
            SizedBox(width: 8),
            Text(
              'Favoritos',
              style: TextStyle(color: Color(0xFF3A506B)),
            ),
          ],
        ),
      ),

      // ===========================
      // CUERPO PRINCIPAL
      // ===========================
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---------------------------
          // 1) Search Bar
          // ---------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SearchBarComponent(
              hintText: 'Buscar Productos...',
              backgroundColor: Colors.grey.shade100,
              borderColor: const Color(0xFFD6D8D8),
              iconColor: const Color(0xFF5BC0BE),
              onSearchChanged: (query) {
                // Si deseas filtrar tu lista de favoritos, podrías hacerlo aquí
              },
              onFilterPressed: () {
                // Opcional: filtrar solo productos de cierto supermercado, etc.
              },
            ),
          ),

          // ---------------------------
          // 2) Sección "Supermercados"
          // ---------------------------
          if (supermercadoIds.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                'Supermercados',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: supermercadoIds.length,
                itemBuilder: (_, index) {
                  final supId = supermercadoIds.elementAt(index);
                  final logoPath = 'assets/logo_$supId.png';

                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Stack(
                      children: [
                        // Contenedor con el logo redondeado
                        Container(
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              logoPath,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) {
                                // Si no existe el logo, mostrar un ícono genérico
                                return Icon(
                                  Icons.store,
                                  size: 40,
                                  color: Colors.grey[500],
                                );
                              },
                            ),
                          ),
                        ),

                        // Botón “X” para eliminar todos los productos de ese supermercado
                        // (Opcional: si quieres eliminar todos los favoritos de ese sup)
                        // Positioned(
                        //   right: 0,
                        //   top: 0,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // Si quisieras eliminar todos los productos de ese supermercado:
                        //       // favService.removeProductsBySupermarket(supId);
                        //     },
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         shape: BoxShape.circle,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black.withOpacity(0.1),
                        //             blurRadius: 4,
                        //           ),
                        //         ],
                        //       ),
                        //       child: const Padding(
                        //         padding: EdgeInsets.all(2.0),
                        //         child: Icon(
                        //           Icons.close,
                        //           size: 16,
                        //           color: Colors.redAccent,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            // Si no hay productos, omitimos la sección
            const SizedBox(height: 8),
          ],

          // ---------------------------
          // 3) Sección "Listas" (opcionales)
          // ---------------------------
          // Como tu FavoritesService no maneja “listas” todavía, la omitimos.
          // Si en el futuro quieres mostrarlas, podrías añadir un getter en el service
          // y luego listar aquí chips similares a “Mercado”, “Despensa”, etc.

          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          //   child: Text(
          //     'Listas',
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.black87,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 40,
          //   child: ListView(
          //     // Aquí enlistarías tus chips de lista
          //   ),
          // ),

          // ---------------------------
          // 4) Sección "Productos"
          // ---------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text(
              'Productos',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          Expanded(
            child: productos.isEmpty
                ? const Center(
                    child: Text(
                      'No tienes productos en favoritos',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: productos.length + 1, // +1 para “+ Agregar otro”
                    separatorBuilder: (_, __) => const Divider(
                      height: 24,
                      color: Colors.grey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      // Si es el último, mostramos el botón “+ Agregar otro producto”
                      if (index == productos.length) {
                        return GestureDetector(
                          onTap: () {
                            // Navegar a la pantalla de búsqueda/selección
                            Navigator.pushNamed(context, '/searchAndAdd');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              children: const [
                                Icon(Icons.add_circle_outline,
                                    color: Color(0xFF84B9BD)),
                                SizedBox(width: 8),
                                Text(
                                  'Agregar otro producto',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF84B9BD)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final Producto p = productos[index];
                      return _FavoriteProductRow(
                        producto: p,
                        onRemove: () {
                          favService.removeFavorite(p);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),

      // ===========================
      // BOTTOM NAVIGATION BAR
      // ===========================
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
    );
  }
}

/// Fila individual de producto favorito
class _FavoriteProductRow extends StatelessWidget {
  final Producto producto;
  final VoidCallback onRemove;

  const _FavoriteProductRow({
    Key? key,
    required this.producto,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Imagen del producto (o placeholder si no hay)
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: producto.imageUrl != null && producto.imageUrl!.trim().isNotEmpty
                ? Image.asset(
                    producto.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported, size: 30),
                  )
                : const Icon(Icons.image_not_supported, size: 30),
          ),
        ),

        const SizedBox(width: 12),

        // Nombre del producto
        Expanded(
          child: Text(
            producto.nombre,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF3A506B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Checkbox (solo visual por ahora)
        Checkbox(
          value: false,
          onChanged: (val) {
            // Aquí podrías marcar el producto como seleccionado para alguna acción
          },
        ),

        // Icono de papelera para eliminar de favoritos
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Color(0xFF84B9BD)),
          splashRadius: 20,
          onPressed: onRemove,
        ),
      ],
    );
  }
}

