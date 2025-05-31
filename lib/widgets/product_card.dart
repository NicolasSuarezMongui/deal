import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onAdd;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.orange; // Ajusta al color de tu marca

    return Container(
      width: 116,
      height: 192,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              width: 91,
              height: 91,
              fit: BoxFit.contain,
            ),
          ),

          // Espacio interno
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),

                // Subtítulo (peso)
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 6,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),

                // Precio
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                SizedBox(height: 2),

                // Botón Agregar
                SizedBox(
                  width: 116,
                  height: 24,
                  child: TextButton.icon(
                    onPressed: onAdd,                    
                    label: Text(
                      'Agregar',
                      style: TextStyle(fontSize: 12),
                    ),
                    icon: Icon(Icons.add, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}