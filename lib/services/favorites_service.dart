// /lib/services/favorites_service.dart

import 'package:flutter/material.dart';
import 'package:deal/models/producto.dart';

/// Servicio singleton que mantiene la lista de productos "favoritos".
class FavoritesService with ChangeNotifier {
  FavoritesService._internal();
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;

  final List<Producto> _favorites = [];

  List<Producto> get favorites => List.unmodifiable(_favorites);

  /// Agrega [producto] a favoritos (si no estaba)
  void addFavorite(Producto producto) {
    if (!_favorites.any((p) => p.codigo == producto.codigo)) {
      _favorites.add(producto);
      notifyListeners();
    }
  }

  /// Elimina [producto] de favoritos (si estaba)
  void removeFavorite(Producto producto) {
    _favorites.removeWhere((p) => p.codigo == producto.codigo);
    notifyListeners();
  }

  /// Retorna si [producto] es favorito
  bool isFavorite(Producto producto) {
    return _favorites.any((p) => p.codigo == producto.codigo);
  }

  /// Vacía todos los favoritos
  void clear() {
    _favorites.clear();
    notifyListeners();
  }
}
