import 'producto.dart';

class ItemCarrito {
  final Producto producto;
  int cantidad;
  final DateTime fechaAgregado;

  ItemCarrito({
    required this.producto,
    this.cantidad = 1,
    DateTime? fechaAgregado,
  }) : fechaAgregado = fechaAgregado ?? DateTime.now();

  double get subtotal => producto.precioFinal * cantidad;

  Map<String, dynamic> toJson() {
    return {
      'producto': producto.toJson(),
      'cantidad': cantidad,
      'fechaAgregado': fechaAgregado.toIso8601String(),
    };
  }

  factory ItemCarrito.fromJson(Map<String, dynamic> json) {
    return ItemCarrito(
      producto: Producto.fromJson(json['producto']),
      cantidad: json['cantidad'],
      fechaAgregado: DateTime.parse(json['fechaAgregado']),
    );
  }
}