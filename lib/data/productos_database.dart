import '../models/producto.dart';

class ProductosDatabase {
  static final ProductosDatabase _instance = ProductosDatabase._internal();
  factory ProductosDatabase() => _instance;
  ProductosDatabase._internal();

  // Categorías disponibles
  static const List<String> categorias = [
    'Frutas y Verduras',
    'Carnes y Pescados',
    'Lácteos',
    'Panadería',
    'Bebidas',
    'Snacks',
    'Limpieza',
    'Cuidado Personal',
    'Bebés',
    'Mascotas',
    'Congelados',
    'Cereales y Granos',
  ];

  // Base de datos de productos
  final Map<String, List<Producto>> _productos = {
    'd1': [
      // Frutas y Verduras
      Producto(codigo: 'D1001', nombre: 'Banano x Kg', precio: 2800, categoria: 'Frutas y Verduras', supermercadoId: 'd1', imageUrl: 'assets/productos/d1_azucar_blanca.png'),
      Producto(codigo: 'D1002', nombre: 'Manzana Roja x Kg', precio: 4500, categoria: 'Frutas y Verduras', supermercadoId: 'd1', imageUrl: 'assets/productos/d1_sal_refisal.png'),
      Producto(codigo: 'D1003', nombre: 'Tomate x Kg', precio: 3200, categoria: 'Frutas y Verduras', supermercadoId: 'd1', imageUrl: 'assets/productos/d1_saltin_noel.png'),
      Producto(codigo: 'D1004', nombre: 'Cebolla Cabezona x Kg', precio: 2500, categoria: 'Frutas y Verduras', supermercadoId: 'd1'),
      Producto(codigo: 'D1005', nombre: 'Papa Criolla x Kg', precio: 3800, categoria: 'Frutas y Verduras', supermercadoId: 'd1'),
      
      // Lácteos
      Producto(codigo: 'D1006', nombre: 'Leche Entera 1L', precio: 3500, categoria: 'Lácteos', supermercadoId: 'd1', imageUrl: 'assets/productos/d1_leche_entera_tetra.png'),
      Producto(codigo: 'D1007', nombre: 'Queso Campesino 500g', precio: 8900, categoria: 'Lácteos', supermercadoId: 'd1'),
      Producto(codigo: 'D1008', nombre: 'Yogurt Natural 900g', precio: 4200, categoria: 'Lácteos', supermercadoId: 'd1'),
      
      // Bebidas
      Producto(codigo: 'D1009', nombre: 'Coca Cola 600ml', precio: 2800, categoria: 'Bebidas', supermercadoId: 'd1', descuento: 10),
      Producto(codigo: 'D1010', nombre: 'Agua Cristal 600ml', precio: 1200, categoria: 'Bebidas', supermercadoId: 'd1'),
      
      // Snacks
      Producto(codigo: 'D1011', nombre: 'Papas Margarita 150g', precio: 3500, categoria: 'Snacks', supermercadoId: 'd1'),
      Producto(codigo: 'D1012', nombre: 'Galletas Noel 250g', precio: 4800, categoria: 'Snacks', supermercadoId: 'd1'),
      
      // Limpieza
      Producto(codigo: 'D1013', nombre: 'Detergente Fab 500g', precio: 6200, categoria: 'Limpieza', supermercadoId: 'd1'),
      Producto(codigo: 'D1014', nombre: 'Papel Higiénico x4', precio: 8500, categoria: 'Limpieza', supermercadoId: 'd1'),
    ],
    
    'exito': [
      // Frutas y Verduras
      Producto(codigo: 'EX001', nombre: 'Banano x Kg', precio: 3200, categoria: 'Frutas y Verduras', supermercadoId: 'exito'),
      Producto(codigo: 'EX002', nombre: 'Manzana Verde x Kg', precio: 5200, categoria: 'Frutas y Verduras', supermercadoId: 'exito'),
      Producto(codigo: 'EX003', nombre: 'Tomate Cherry x 250g', precio: 4800, categoria: 'Frutas y Verduras', supermercadoId: 'exito'),
      Producto(codigo: 'EX004', nombre: 'Aguacate Hass x Unidad', precio: 2800, categoria: 'Frutas y Verduras', supermercadoId: 'exito'),
      
      // Carnes y Pescados
      Producto(codigo: 'EX005', nombre: 'Pollo Entero x Kg', precio: 7800, categoria: 'Carnes y Pescados', supermercadoId: 'exito'),
      Producto(codigo: 'EX006', nombre: 'Carne Molida x Kg', precio: 14500, categoria: 'Carnes y Pescados', supermercadoId: 'exito'),
      Producto(codigo: 'EX007', nombre: 'Salmón Fresco x Kg', precio: 35000, categoria: 'Carnes y Pescados', supermercadoId: 'exito'),
      
      // Lácteos Premium
      Producto(codigo: 'EX008', nombre: 'Leche Deslactosada 1L', precio: 4200, categoria: 'Lácteos', supermercadoId: 'exito'),
      Producto(codigo: 'EX009', nombre: 'Queso Mozzarella 200g', precio: 8900, categoria: 'Lácteos', supermercadoId: 'exito'),
      Producto(codigo: 'EX010', nombre: 'Mantequilla 250g', precio: 6500, categoria: 'Lácteos', supermercadoId: 'exito'),
      
      // Bebidas Premium
      Producto(codigo: 'EX011', nombre: 'Jugo Natural Naranja 1L', precio: 5800, categoria: 'Bebidas', supermercadoId: 'exito'),
      Producto(codigo: 'EX012', nombre: 'Vino Tinto 750ml', precio: 28000, categoria: 'Bebidas', supermercadoId: 'exito'),
      
      // Panadería
      Producto(codigo: 'EX013', nombre: 'Pan Integral x6', precio: 4500, categoria: 'Panadería', supermercadoId: 'exito'),
      Producto(codigo: 'EX014', nombre: 'Croissant x4', precio: 6800, categoria: 'Panadería', supermercadoId: 'exito'),
    ],
    
    'makro': [
      // Productos al por mayor
      Producto(codigo: 'MK001', nombre: 'Arroz Diana 5Kg', precio: 18500, categoria: 'Cereales y Granos', supermercadoId: 'makro'),
      Producto(codigo: 'MK002', nombre: 'Aceite Gourmet 3L', precio: 22800, categoria: 'Cereales y Granos', supermercadoId: 'makro'),
      Producto(codigo: 'MK003', nombre: 'Pollo Congelado 2.5Kg', precio: 19500, categoria: 'Congelados', supermercadoId: 'makro'),
      Producto(codigo: 'MK004', nombre: 'Papel Higiénico x24', precio: 48000, categoria: 'Limpieza', supermercadoId: 'makro'),
      Producto(codigo: 'MK005', nombre: 'Atún Lata x12', precio: 35000, categoria: 'Cereales y Granos', supermercadoId: 'makro'),
      
      // Bebidas al por mayor
      Producto(codigo: 'MK006', nombre: 'Coca Cola x12 600ml', precio: 28000, categoria: 'Bebidas', supermercadoId: 'makro'),
      Producto(codigo: 'MK007', nombre: 'Agua x24 500ml', precio: 18000, categoria: 'Bebidas', supermercadoId: 'makro'),
      
      // Limpieza Industrial
      Producto(codigo: 'MK008', nombre: 'Detergente Ariel 4Kg', precio: 35000, categoria: 'Limpieza', supermercadoId: 'makro'),
      Producto(codigo: 'MK009', nombre: 'Jabón Líquido 5L', precio: 25000, categoria: 'Limpieza', supermercadoId: 'makro'),
    ],
    
    'jumbo': [
      // Productos similares pero con precios diferentes
      Producto(codigo: 'JB001', nombre: 'Banano Orgánico x Kg', precio: 4500, categoria: 'Frutas y Verduras', supermercadoId: 'jumbo'),
      Producto(codigo: 'JB002', nombre: 'Manzana Fuji x Kg', precio: 6200, categoria: 'Frutas y Verduras', supermercadoId: 'jumbo'),
      Producto(codigo: 'JB003', nombre: 'Salmón Ahumado 150g', precio: 18500, categoria: 'Carnes y Pescados', supermercadoId: 'jumbo'),
      Producto(codigo: 'JB004', nombre: 'Queso Parmesano 200g', precio: 15800, categoria: 'Lácteos', supermercadoId: 'jumbo'),
      
      // Productos gourmet
      Producto(codigo: 'JB005', nombre: 'Aceite Oliva Extra Virgen', precio: 24000, categoria: 'Cereales y Granos', supermercadoId: 'jumbo'),
      Producto(codigo: 'JB006', nombre: 'Jamón Serrano 100g', precio: 12500, categoria: 'Carnes y Pescados', supermercadoId: 'jumbo'),
      Producto(codigo: 'JB007', nombre: 'Chocolate Lindt 100g', precio: 8900, categoria: 'Snacks', supermercadoId: 'jumbo'),
      
      // Congelados
      Producto(codigo: 'JB008', nombre: 'Pizza Congelada', precio: 12800, categoria: 'Congelados', supermercadoId: 'jumbo'),
      Producto(codigo: 'JB009', nombre: 'Helado 1L', precio: 15500, categoria: 'Congelados', supermercadoId: 'jumbo'),
    ],
    
    'ara': [
      // Productos básicos
      Producto(codigo: 'AR001', nombre: 'Banano x Kg', precio: 2900, categoria: 'Frutas y Verduras', supermercadoId: 'ara'),
      Producto(codigo: 'AR002', nombre: 'Papa x Kg', precio: 2800, categoria: 'Frutas y Verduras', supermercadoId: 'ara'),
      Producto(codigo: 'AR003', nombre: 'Leche 1L', precio: 3800, categoria: 'Lácteos', supermercadoId: 'ara'),
      Producto(codigo: 'AR004', nombre: 'Pan Tajado', precio: 3200, categoria: 'Panadería', supermercadoId: 'ara'),
      Producto(codigo: 'AR005', nombre: 'Huevos x30', precio: 12500, categoria: 'Lácteos', supermercadoId: 'ara'),
      
      // Bebidas
      Producto(codigo: 'AR006', nombre: 'Gaseosa 1.5L', precio: 4200, categoria: 'Bebidas', supermercadoId: 'ara', descuento: 15),
      Producto(codigo: 'AR007', nombre: 'Jugo Hit 200ml', precio: 1800, categoria: 'Bebidas', supermercadoId: 'ara'),
      
      // Cuidado Personal
      Producto(codigo: 'AR008', nombre: 'Shampoo 400ml', precio: 8500, categoria: 'Cuidado Personal', supermercadoId: 'ara'),
      Producto(codigo: 'AR009', nombre: 'Jabón de Baño x3', precio: 5800, categoria: 'Cuidado Personal', supermercadoId: 'ara'),
      
      // Productos para bebés
      Producto(codigo: 'AR010', nombre: 'Pañales Talla M x30', precio: 28000, categoria: 'Bebés', supermercadoId: 'ara'),
      Producto(codigo: 'AR011', nombre: 'Leche Formula 400g', precio: 32000, categoria: 'Bebés', supermercadoId: 'ara'),
    ],
  };

  // Métodos para acceder a los productos
  List<Producto> obtenerProductosPorSupermercado(String supermercadoId) {
    return _productos[supermercadoId] ?? [];
  }

  List<Producto> buscarProductos(String supermercadoId, String query) {
    final productos = obtenerProductosPorSupermercado(supermercadoId);
    if (query.isEmpty) return productos;
    
    return productos.where((producto) => producto.coincideBusqueda(query)).toList();
  }

  List<Producto> filtrarPorCategoria(String supermercadoId, String categoria) {
    final productos = obtenerProductosPorSupermercado(supermercadoId);
    return productos.where((producto) => producto.categoria == categoria).toList();
  }

  List<Producto> buscarYFiltrar(String supermercadoId, String query, String? categoria) {
    var productos = obtenerProductosPorSupermercado(supermercadoId);
    
    if (query.isNotEmpty) {
      productos = productos.where((producto) => producto.coincideBusqueda(query)).toList();
    }
    
    if (categoria != null && categoria.isNotEmpty) {
      productos = productos.where((producto) => producto.categoria == categoria).toList();
    }
    
    return productos;
  }

  List<String> obtenerCategoriasPorSupermercado(String supermercadoId) {
    final productos = obtenerProductosPorSupermercado(supermercadoId);
    final categoriasSet = productos.map((p) => p.categoria).toSet();
    return categoriasSet.toList()..sort();
  }

  // Método para obtener productos con descuento
  List<Producto> obtenerProductosEnOferta(String supermercadoId) {
    final productos = obtenerProductosPorSupermercado(supermercadoId);
    return productos.where((producto) => producto.descuento != null && producto.descuento! > 0).toList();
  }

  // Método para comparar precios entre supermercados
  List<Map<String, dynamic>> compararPrecios(String nombreProducto) {
    List<Map<String, dynamic>> comparacion = [];
    
    _productos.forEach((supermercadoId, productos) {
      final producto = productos.firstWhere(
        (p) => p.nombre.toLowerCase().contains(nombreProducto.toLowerCase()),
        orElse: () => productos.first, // Fallback, en producción manejar mejor
      );
      
      if (producto.nombre.toLowerCase().contains(nombreProducto.toLowerCase())) {
        comparacion.add({
          'supermercado': supermercadoId,
          'producto': producto,
        });
      }
    });
    
    // Ordenar por precio
    comparacion.sort((a, b) => a['producto'].precioFinal.compareTo(b['producto'].precioFinal));
    
    return comparacion;
  }

  // Método para obtener estadísticas
  Map<String, int> obtenerEstadisticasSupermercado(String supermercadoId) {
    final productos = obtenerProductosPorSupermercado(supermercadoId);
    final categorias = obtenerCategoriasPorSupermercado(supermercadoId);
    final ofertas = obtenerProductosEnOferta(supermercadoId);
    
    return {
      'totalProductos': productos.length,
      'totalCategorias': categorias.length,
      'productosEnOferta': ofertas.length,
    };
  }

  List<Producto> obtenerProductosPorCategoriaGlobal(String categoria) {
    List<Producto> resultado = [];
    _productos.forEach((superId, lista) {
      resultado.addAll(
        lista.where((producto) => producto.categoria == categoria),
      );
    });
    return resultado;
  }

  List<Producto> obtenerProductos(){
    List<Producto> resultado = [];
    _productos.forEach((superId, lista) {
      resultado.addAll(lista);
    });
    return resultado;
  }
}