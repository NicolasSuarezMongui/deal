// /lib/widgets/categories.dart

import 'package:flutter/material.dart';
import 'package:deal/data/productos_database.dart';

/// Modelo simple para representar una categoría con su ícono (asset) y su clave (título).
class Categoria {
  final String imageUrl; // Ruta del asset (icono) de la categoría
  final String titulo;   // Nombre textual “identificador” de la categoría

  Categoria({required this.imageUrl, required this.titulo});
}

/// Callback que devuelve el nombre de la categoría seleccionada.
typedef CategoryTapCallback = void Function(String categoriaTitulo);

/// Widget que despliega una lista horizontal de iconos (imágenes), con sombra y borde redondeado.
/// Al tocar cualquiera, dispara [onCategoryTap] con el campo `titulo`.
class CategoryWidget extends StatelessWidget {
  /// Lista de objetos Categoria (imagen + titulo) a mostrar.
  final List<Categoria> categorias;

  /// Callback que se dispara al tocar cada categoría, recibiendo su `titulo`.
  final CategoryTapCallback onCategoryTap;

  const CategoryWidget({
    Key? key,
    required this.categorias,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Si la lista viene vacía, devolvemos un SizedBox para no pintar nada.
    if (categorias.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 80, // Ajusta este alto a tus necesidades: icono + margen/padding
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categorias.length,
        itemBuilder: (_, index) {
          final cat = categorias[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                onCategoryTap(cat.titulo);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Contenedor circular o con bordes blandos para el icono
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD6D8D8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        cat.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) {
                          // Si falla al cargar el asset, mostramos un icono genérico
                          return Icon(
                            Icons.category,
                            color: Colors.grey[400],
                            size: 24,
                          );
                        },
                      ),
                    ),
                  ),

                  //const SizedBox(height: 4),
                  // (Opcional) Si quieres mostrar un pequeño texto debajo:
                  // Text(cat.titulo, style: TextStyle(fontSize: 12, color: Color(0xFF34495E))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Clase auxiliar que centraliza el mapa “nombre de categoría → ruta de icono”
/// y provee métodos para obtener listas de Categoria en Home o por supermercado.
class CategoryData {
  CategoryData._(); // Constructor privado para que no se instancie

  /// Mapa interno: cada categoría textual mapea a un asset en tu carpeta `assets/`.
  static const Map<String, String> _categoriaIconMap = {
    'Frutas y Verduras': 'assets/cat_verduras.png',
    'Carnes y Pescados': 'assets/cat_alimentos.png',
    'Lácteos': 'assets/cat_lacteos.png',
    'Panadería': 'assets/cat_alimentos.png',
    'Bebidas': 'assets/cat_bebidas.png',
    'Snacks': 'assets/cat_snack.png',
    'Limpieza': 'assets/cat_aseo.png',
    'Cuidado Personal': 'assets/cat_personal.png',
    'Bebés': 'assets/cat_alimentos.png',
    'Mascotas': 'assets/cat_mascotas.png',
    'Congelados': 'assets/cat_congelados.png',
    'Cereales y Granos': 'assets/cat_alimentos.png',
  };

  /// Si una categoría no está en el mapa, devolvemos este icono “por defecto”.
  static const String _defaultIcon = 'assets/cat_default.png';

  /// Devuelve la ruta de icono para la categoría [nombreCat]. Si no existe en el mapa,
  /// retorna [_defaultIcon].
  static String _iconPathPara(String nombreCat) {
    return _categoriaIconMap[nombreCat] ?? _defaultIcon;
  }

  /// Retorna una lista de objetos `Categoria` que incluyan **todas** las categorías
  /// declaradas en [ProductosDatabase.categorias].
  static List<Categoria> obtenerCategoriasGlobales() {
    return ProductosDatabase.categorias.map((nombreCat) {
      final path = _iconPathPara(nombreCat);
      return Categoria(imageUrl: path, titulo: nombreCat);
    }).toList();
  }

  /// Retorna una lista de objetos `Categoria` que incluyan solo las categorías
  /// que realmente existan en el supermercado [supermercadoId].
  static List<Categoria> obtenerCategoriasPorSupermercado(String supermercadoId) {
    // 1) Obtenemos los nombres (String) de las categorías que existen en ese sup.
    final nombres = ProductosDatabase().obtenerCategoriasPorSupermercado(supermercadoId);
    // 2) Mapeamos cada nombre a un icono usando nuestro mapa interno.
    return nombres.map((nombreCat) {
      final path = _iconPathPara(nombreCat);
      return Categoria(imageUrl: path, titulo: nombreCat);
    }).toList();
  }
}
