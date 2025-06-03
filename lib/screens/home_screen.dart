import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:deal/data/productos_database.dart';
import 'package:deal/screens/product_list_screen.dart';
import 'package:deal/widgets/custom_bottom_nav_bar.dart';

// Estos imports apuntan a los widgets que ya tenías creados (o bien,
// reemplázalos por tu propia implementación “inline” si lo prefieres).
import '../widgets/promo_carrusel.dart';
import '../widgets/categories.dart';
import '../widgets/tools_component.dart';
import '../widgets/supermarkets.dart';
import '../widgets/searchbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Definimos los colores que usa todo el layout (basados en el mockup)
    const Color colorPrincipal = Color(0xFF0B132B);    // Azul muy oscuro para bottom bar
    const Color colorSecundario = Color(0xFF5BC0BE);   // Azul turquesa para íconos/pestañas
    const Color colorFondo = Colors.white;             // Fondo general
    const Color colorTexto = Color(0xFF34495E);        // Color de texto principal
    const Color colorSubtexto = Color(0xFF5BC0BE);     // Color de subtítulos (más claro)
    const Color colorBordeLigero = Color(0xFFD6D8D8);  // Color de bordes suaves
    const Color colorGrisClaro = Color(0xFFF5F5F5);    // Fondo gris muy claro para contenedores.

    final listaCategoriasGlobal = CategoryData.obtenerCategoriasGlobales();

    return Scaffold(
      backgroundColor: colorFondo,
      // Evitamos que el status bar sea oscuro/transparent — lo dejamos en negro con íconos claros
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: colorFondo,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: colorFondo,
        elevation: 0,
        automaticallyImplyLeading: false,
        // Aquí no hay contenido, porque vamos a poner el SearchBar dentro del body
        toolbarHeight: 0,
      ),

      body: SafeArea(
        child: DefaultTabController(
          length: 3, // Para el SegmentedControl: Top 10, Descuentos, Nuevos
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // 1) SearchBar en la parte superior
                // =========================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: SearchBarComponent(
                    hintText: 'Buscar Productos...',
                    backgroundColor: colorGrisClaro,
                    borderColor: colorBordeLigero,
                    iconColor: colorSecundario,
                    onSearchChanged: (query) {
                      print('Buscando: $query');
                    },
                    onFilterPressed: () {
                      print('Se presionó filtro');
                    },
                  ),
                ),

                // =========================
                // 2) Sección “Promociones” + carrusel
                // =========================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Promociones',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorTexto,
                        ),
                      ),
                      Icon(Icons.more_horiz, color: colorSecundario, size: 24),
                    ],
                  ),
                ),
                // Aqui asumimos que PromocionesCarrusel es un widget que despliega un PageView
                // o un ListView horizontal con las imágenes de promoción.
                // Si no lo tienes, crea un widget que reciba una lista de URLs o Assets.
                PromocionesCarrusel(),

                // =========================
                // 3) Sección “Categorías” + botones redondeados
                // =========================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categorías',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorTexto,
                        ),
                      ),
                      Icon(Icons.more_horiz, color: colorSecundario, size: 24),
                    ],
                  ),
                ),
                // Suponemos que CategoryWidget despliega un ListView.horizontal con cada categoría.
                CategoryWidget(
                  categorias: listaCategoriasGlobal,
                  onCategoryTap: (String categoriaSeleccionada) {
                    // 1) Obtenemos desde la DB todos los productos de esa categoría
                    final productosFiltrados = ProductosDatabase()
                        .obtenerProductosPorCategoriaGlobal(categoriaSeleccionada);

                    // 2) Navegamos a ProductListScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListScreen(
                          title: 'Productos: $categoriaSeleccionada',
                          productos: productosFiltrados,
                        ),
                      ),
                    );
                  },
                ),

                // =========================
                // 4) Sección “Herramientas”
                // =========================
                //SizedBox(height: 8),
                // Asumimos que ToolsComponent despliega dos botones (“Mapa” y “Scanner”)
                ToolsComponent(),

                // =========================
                // 5) Sección “Supermercados”
                // =========================
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Supermercados',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorTexto,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Suponemos que SupermarketWidget despliega un PageView o ListView horizontal
                // con tarjetas de cada logo de supermercado (D1, Éxito, Makro).
                SupermarketWidget(),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),

      // =========================
      // 6) BottomNavigationBar personalizado
      // =========================
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0)
    );
  }
}
