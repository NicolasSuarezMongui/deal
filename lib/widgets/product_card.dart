// /lib/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:deal/models/producto.dart';
import 'package:deal/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  /// Recibimos directamente el modelo [Producto].
  final Producto producto;

  /// Callback cuando el usuario pulsa “Agregar” (al carrito).
  final VoidCallback onAdd;

  const ProductCard({
    Key? key,
    required this.producto,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color base para borde y botón
    final Color colorNaranja = const Color(0xFF2885B6);

    return GestureDetector(
      onTap: () {
        // Al tocar toda la tarjeta, navegamos a ProductDetailScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(producto: producto),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: colorNaranja.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          // AspectRatio para que el GridView lo dimensione correctamente
          child: AspectRatio(
            aspectRatio: 116 / 192, // ancho / alto ≈ 0.604
            // LayoutBuilder para medir ancho disponible y escalar textos
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double cardWidth = constraints.maxWidth;

                // Factores de escala basados en ancho de tarjeta
                final double titleFontSize    = (cardWidth * 0.08).clamp(8.0, 14.0);
                final double subtitleFontSize = (cardWidth * 0.06).clamp(6.0, 10.0);
                final double priceFontSize    = (cardWidth * 0.12).clamp(12.0, 18.0);
                final double buttonFontSize   = (cardWidth * 0.05).clamp(10.0, 14.0);
                final double iconSize         = (cardWidth * 0.07).clamp(12.0, 20.0);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ================================
                    // 1) SECCIÓN IMAGEN (45% alto)
                    // ================================
                    Expanded(
                      flex: 45,
                      child: _buildImageSection(),
                    ),

                    // ================================
                    // 2) SECCIÓN TEXTO (40% alto)
                    // ================================
                    Expanded(
                      flex: 40,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: cardWidth * 0.07, // p.ej. 8px en ancho=116
                          vertical: cardWidth * 0.02,   // p.ej. ~2px
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TÍTULO (hasta 2 líneas)
                            Text(
                              producto.nombre.toUpperCase(),
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: cardWidth * 0.01),

                            // SUBTÍTULO (categoría o peso)
                            Text(
                              producto.categoria,
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: cardWidth * 0.02),

                            // PRECIO final (con descuento si existe)
                            Text(
                              '\$ ${producto.precioFinal.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: priceFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // =================================
                    // 3) SECCIÓN BOTÓN “AGREGAR” (15% alto)
                    // =================================
                    Expanded(
                      flex: 15,
                      child: TextButton.icon(
                        onPressed: onAdd,
                        icon: Icon(
                          Icons.add,
                          size: iconSize,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Agregar',
                          style: TextStyle(
                            fontSize: buttonFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: colorNaranja,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Construye la sección de la imagen:
  /// - Si producto.imageUrl es null o vacío, muestra el logo del supermercado centrado.
  /// - Si existe, carga la imagen del producto (asset).
  Widget _buildImageSection() {
    final bool hasImage =
        producto.imageUrl != null && producto.imageUrl!.trim().isNotEmpty;
    final String placeholderLogo = 'assets/logo_${producto.supermercadoId}.png';

    if (!hasImage) {
      // Mostramos el logo del supermercado centrado
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          placeholderLogo,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Si tampoco existe el logo, mostramos un icono genérico
            return const Icon(Icons.store, size: 40, color: Colors.grey);
          },
        ),
      );
    }

    // Si imageUrl está definido, lo cargamos como asset. Si fuera una URL, usar Image.network.
    return Image.asset(
      producto.imageUrl!,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // En caso de error al cargar la imagen, caemos al placeholder del supermercado
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            placeholderLogo,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return const Icon(Icons.store, size: 40, color: Colors.grey);
            },
          ),
        );
      },
    );
  }
}
