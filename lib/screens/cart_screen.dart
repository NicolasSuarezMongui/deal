// /lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deal/services/cart_service.dart';
import 'package:deal/models/item_carrito.dart';
import 'package:deal/widgets/searchbar.dart';
import 'package:deal/widgets/custom_bottom_nav_bar.dart'; 

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Escuchamos el CartService para rebuild cuando cambie
    final cartService = context.watch<CartService>();
    final items = cartService.items;

    return Scaffold(
      // ===========================
      // APPBAR PERSONALIZADO
      // ===========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.shopping_cart, color: Color(0xFF3A506B)),
            SizedBox(width: 8),
            Text(
              'Carrito',
              style: TextStyle(color: Color(0xFF3A506B)),
            ),
          ],
        ),
      ),

      // ===========================
      // BOTTOM NAVIGATION BAR (ahora como propiedad de Scaffold)
      // ===========================
      //bottomNavigationBar: const _MyBottomNavBar(),

      // ===========================
      // CUERPO PRINCIPAL
      // ===========================
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ===========================
          // SEARCH BAR
          // ===========================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SearchBarComponent(
              hintText: 'Buscar Productos...',
              backgroundColor: Colors.grey.shade100,
              borderColor: const Color(0xFFD6D8D8),
              iconColor: const Color(0xFF5BC0BE),
              onSearchChanged: (query) {
                // Aquí podrías filtrar la lista del carrito si quisieras
              },
              onFilterPressed: () {
                // Si quieres agregar un filtro para el carrito
              },
            ),
          ),

          // ===========================
          // TÍTULO “Productos”
          // ===========================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Productos',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),

          // ===========================
          // LISTA DE ITEMS EN EL CARRITO
          // ===========================
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text(
                      'Tu carrito está vacío',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: items.length + 1, // +1 para el botón “+ Agregar otro”
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      // Si es el último índice, mostramos el botón para agregar otro producto
                      if (index == items.length) {
                        return GestureDetector(
                          onTap: () {
                            // Navegar a la pantalla donde el usuario pueda buscar y agregar más productos
                            Navigator.pushNamed(context, '/searchAndAdd');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: const [
                                Icon(Icons.add_circle_outline, color: Color(0xFF84B9BD)),
                                SizedBox(width: 8),
                                Text(
                                  'Agregar otro producto',
                                  style: TextStyle(fontSize: 14, color: Color(0xFF84B9BD)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // De lo contrario, construimos la fila de cada producto
                      final ItemCarrito item = items[index];
                      return _CartItemRow(
                        item: item,
                        onIncrement: () {
                          cartService.addProduct(item.producto);
                        },
                        onDecrement: () {
                          cartService.decreaseProduct(item.producto);
                        },
                        onRemove: () {
                          cartService.removeProductCompletely(item.producto);
                        },
                      );
                    },
                  ),
          ),

          // ===========================
          // BARRA INFERIOR CON TOTAL Y BOTÓN “Comprar”
          // ===========================
          // La colocamos fuera del Expanded, justo encima del bottomNavigationBar
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF0B132B),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -1)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              children: [
                // Total
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          '\$${cartService.totalCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Botón “Comprar”
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Lógica de checkout / finalizar compra
                      // Ejemplo: Navigator.pushNamed(context, '/checkout');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF5BC0BE),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Center(
                      child: Text(
                        'Comprar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
    );
  }
}

/// Widget auxiliar que representa cada fila de producto en el carrito
class _CartItemRow extends StatelessWidget {
  final ItemCarrito item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartItemRow({
    Key? key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox (puedes enlazarlo a algún estado si luego quieres usarlo)
        Checkbox(
          value: false,
          onChanged: (val) {
            // Si quieres mantener seleccionado el item o no
          },
        ),

        // Nombre del producto
        Expanded(
          child: Text(
            item.producto.nombre,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF3A506B),
                fontWeight: FontWeight.w600),
          ),
        ),

        // Botón “−”
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove, size: 20),
            splashRadius: 20,
            onPressed: onDecrement,
          ),
        ),

        // Cantidad
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            item.cantidad.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        // Botón “+”
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, size: 20),
            splashRadius: 20,
            onPressed: onIncrement,
          ),
        ),

        // Ícono de papelera para eliminar
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.grey),
          splashRadius: 20,
          onPressed: onRemove,
        ),
      ],
    );
  }
}
