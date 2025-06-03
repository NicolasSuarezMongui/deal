import 'package:flutter/material.dart';
import 'package:deal/models/producto.dart';
import 'package:deal/widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final List<Producto> productos;

  const ProductListScreen({
    Key? key,
    required this.title,
    required this.productos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Si no hay productos, mostramos un mensaje de “Sin resultados”
    if (productos.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF34495E),
          elevation: 1,
        ),
        body: Center(
          child: Text(
            'No se encontraron productos',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF34495E),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: GridView.builder(
          itemCount: productos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.6, // la misma proporción que usa ProductCard
          ),
          itemBuilder: (context, index) {
            final p = productos[index];
            return ProductCard(
              producto: p,
              onAdd: () {
                // Lógica para agregar al carrito, por ejemplo:
                print('Agregando ${p.nombre} del supermercado ${p.supermercadoId}');
              },
            );
          },
        ),
      ),
    );
  }
}
