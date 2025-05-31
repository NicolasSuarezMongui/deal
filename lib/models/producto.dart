class Producto {
  final String codigo;
  final String nombre;
  final double precio;
  final String categoria;
  final String? descripcion;
  final String? imageUrl;
  final String supermercadoId;
  final bool disponible;
  final double? descuento; // Porcentaje de descuento (0-100)

  Producto({
    required this.codigo,
    required this.nombre,
    required this.precio,
    required this.categoria,
    required this.supermercadoId,
    this.descripcion,
    this.imageUrl,
    this.disponible = true,
    this.descuento,
  });

  // Precio con descuento aplicado
  double get precioFinal {
    if (descuento != null && descuento! > 0) {
      return precio - (precio * (descuento! / 100));
    }
    return precio;
  }

  // Para búsqueda y filtrado
  bool coincideBusqueda(String query) {
    return nombre.toLowerCase().contains(query.toLowerCase()) ||
           codigo.toLowerCase().contains(query.toLowerCase()) ||
           categoria.toLowerCase().contains(query.toLowerCase());
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'precio': precio,
      'categoria': categoria,
      'descripcion': descripcion,
      'imageUrl': imageUrl,
      'supermercadoId': supermercadoId,
      'disponible': disponible,
      'descuento': descuento,
    };
  }

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      codigo: json['codigo'],
      nombre: json['nombre'],
      precio: json['precio'].toDouble(),
      categoria: json['categoria'],
      supermercadoId: json['supermercadoId'],
      descripcion: json['descripcion'],
      imageUrl: json['imageUrl'],
      disponible: json['disponible'] ?? true,
      descuento: json['descuento']?.toDouble(),
    );
  }
}