// /lib/services/cart_service.dart

import 'package:flutter/material.dart';
import 'package:deal/models/producto.dart';
import 'package:deal/models/item_carrito.dart';

class CartService with ChangeNotifier {
  CartService._internal();
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;

  final List<ItemCarrito> _items = [];

  List<ItemCarrito> get items => List.unmodifiable(_items);

  void addProduct(Producto producto) {
    final index = _items.indexWhere((item) => item.producto.codigo == producto.codigo);
    if (index != -1) {
      _items[index].cantidad += 1;
    } else {
      _items.add(ItemCarrito(producto: producto));
    }
    notifyListeners();
  }

  void removeProductCompletely(Producto producto) {
    _items.removeWhere((item) => item.producto.codigo == producto.codigo);
    notifyListeners();
  }

  /// Disminuye en 1 la cantidad; si llega a cero, lo borra del carrito
  void decreaseProduct(Producto producto) {
    final index = _items.indexWhere((item) => item.producto.codigo == producto.codigo);
    if (index != -1) {
      if (_items[index].cantidad > 1) {
        _items[index].cantidad -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  int get totalItems => _items.fold(0, (sum, item) => sum + item.cantidad);

  double get totalCost => _items.fold(0.0, (sum, item) => sum + item.subtotal);
}
