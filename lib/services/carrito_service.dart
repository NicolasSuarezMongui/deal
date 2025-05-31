import '../models/item_carrito.dart';
import '../models/producto.dart';
import '../data/productos_database.dart';

class CarritoService {
  static final CarritoService _instance = CarritoService._internal();
  factory CarritoService() => _instance;
  CarritoService._internal();

  final Map<String, List<ItemCarrito>> _carritos = {};
  
  // Obtener carrito por supermercado
  List<ItemCarrito> obtenerCarrito(String supermercadoId) {
    return _carritos[supermercadoId] ?? [];
  }

  // Agregar producto al carrito
  void agregarProducto(String supermercadoId, Producto producto, {int cantidad = 1}) {
    if (!_carritos.containsKey(supermercadoId)) {
      _carritos[supermercadoId] = [];
    }

    final carrito = _carritos[supermercadoId]!;
    
    // Verificar si el producto ya existe en el carrito
    final indiceExistente = carrito.indexWhere((item) => item.producto.codigo == producto.codigo);
    
    if (indiceExistente != -1) {
      // Si existe, aumentar la cantidad
      carrito[indiceExistente].cantidad += cantidad;
    } else {
      // Si no existe, agregar nuevo item
      carrito.add(ItemCarrito(producto: producto, cantidad: cantidad));
    }
  }

  // Remover producto del carrito
  void removerProducto(String supermercadoId, String codigoProducto) {
    if (_carritos.containsKey(supermercadoId)) {
      _carritos[supermercadoId]!.removeWhere((item) => item.producto.codigo == codigoProducto);
    }
  }

  // Actualizar cantidad de un producto
  void actualizarCantidad(String supermercadoId, String codigoProducto, int nuevaCantidad) {
    if (_carritos.containsKey(supermercadoId)) {
      final carrito = _carritos[supermercadoId]!;
      final indice = carrito.indexWhere((item) => item.producto.codigo == codigoProducto);
      
      if (indice != -1) {
        if (nuevaCantidad <= 0) {
          carrito.removeAt(indice);
        } else {
          carrito[indice].cantidad = nuevaCantidad;
        }
      }
    }
  }

  // Limpiar carrito
  void limpiarCarrito(String supermercadoId) {
    _carritos[supermercadoId] = [];
  }

  // Obtener total del carrito
  double obtenerTotal(String supermercadoId) {
    final carrito = obtenerCarrito(supermercadoId);
    return carrito.fold(0.0, (total, item) => total + item.subtotal);
  }

  // Obtener cantidad total de items
  int obtenerCantidadTotal(String supermercadoId) {
    final carrito = obtenerCarrito(supermercadoId);
    return carrito.fold(0, (total, item) => total + item.cantidad);
  }

  // Verificar si el carrito está vacío
  bool estaVacio(String supermercadoId) {
    return obtenerCarrito(supermercadoId).isEmpty;
  }

  // Obtener descuento total
  double obtenerDescuentoTotal(String supermercadoId) {
    final carrito = obtenerCarrito(supermercadoId);
    double descuentoTotal = 0.0;
    
    for (final item in carrito) {
      if (item.producto.descuento != null && item.producto.descuento! > 0) {
        double descuentoPorUnidad = item.producto.precio * (item.producto.descuento! / 100);
        descuentoTotal += descuentoPorUnidad * item.cantidad;
      }
    }
    
    return descuentoTotal;
  }

  // Obtener resumen del carrito
  Map<String, dynamic> obtenerResumenCarrito(String supermercadoId) {
    final carrito = obtenerCarrito(supermercadoId);
    final subtotal = carrito.fold(0.0, (total, item) => total + (item.producto.precio * item.cantidad));
    final descuento = obtenerDescuentoTotal(supermercadoId);
    final total = obtenerTotal(supermercadoId);

    return {
      'items': carrito.length,
      'cantidadTotal': obtenerCantidadTotal(supermercadoId),
      'subtotal': subtotal,
      'descuento': descuento,
      'total': total,
    };
  }

  // Método para transferir productos entre carritos (cambiar de supermercado)
  void transferirCarrito(String supermercadoOrigen, String supermercadoDestino) {
    if (_carritos.containsKey(supermercadoOrigen)) {
      final carritoOrigen = _carritos[supermercadoOrigen]!;
      
      // Buscar productos equivalentes en el supermercado destino
      final productosDb = ProductosDatabase();
      final productosDestino = productosDb.obtenerProductosPorSupermercado(supermercadoDestino);
      
      for (final itemOrigen in carritoOrigen) {
        // Buscar producto similar por nombre
        final productoSimilar = productosDestino.firstWhere(
          (p) => p.nombre.toLowerCase() == itemOrigen.producto.nombre.toLowerCase(),
          orElse: () => productosDestino.first, // Fallback, manejar mejor en producción
        );
        
        if (productoSimilar.nombre.toLowerCase() == itemOrigen.producto.nombre.toLowerCase()) {
          agregarProducto(supermercadoDestino, productoSimilar, cantidad: itemOrigen.cantidad);
        }
      }
      
      // Limpiar carrito origen
      limpiarCarrito(supermercadoOrigen);
    }
  }
}