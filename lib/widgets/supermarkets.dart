import 'package:flutter/material.dart';
import 'package:deal/data/productos_database.dart';
import 'package:deal/models/producto.dart';
import 'package:deal/widgets/categories.dart';
import 'package:deal/widgets/promo_carrusel.dart';
import 'package:deal/widgets/searchbar.dart';
import 'package:deal/widgets/rounded_app_bar.dart';
import 'package:deal/widgets/product_card.dart';
import 'package:deal/screens/product_list_screen.dart';
import 'package:deal/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:deal/widgets/custom_bottom_nav_bar.dart';


// Modelo mejorado para representar supermercados con más información
class Supermercado {
  final String id;
  final String imageUrl;
  final String titulo;
  final String nombre; // Nombre real del supermercado
  final Color colorPrimario;
  final Color colorSecundario;
  final Color colorTexto;
  final String slogan;

  Supermercado({
    required this.id,
    required this.imageUrl,
    required this.titulo,
    required this.nombre,
    required this.colorPrimario,
    required this.colorSecundario,
    required this.colorTexto,
    required this.slogan,
  });
}

// Widget del componente de supermercados actualizado con navegación
class SupermarketWidget extends StatelessWidget {
  // Lista con información completa de cada supermercado
  final List<Supermercado> promociones = [
    Supermercado(
      id: 'd1',
      imageUrl: 'assets/logo_d1.png',
      titulo: 'Supermercado 1',
      nombre: 'D1',
      colorPrimario: Color(0xFFE31E24),
      colorSecundario: Color(0xFFFFFFFF),
      colorTexto: Colors.white,
      slogan: 'Precio Justo, Siempre',
    ),
    Supermercado(
      id: 'exito',
      imageUrl: 'assets/logo_exito.png',
      titulo: 'Supermercado 2',
      nombre: 'Éxito',
      colorPrimario: Color(0xFFFDD700),
      colorSecundario: Color(0xFFFFFFFF),
      colorTexto: Colors.black,
      slogan: 'Vive la experiencia',
    ),
    Supermercado(
      id: 'makro',
      imageUrl: 'assets/logo_makro.png',
      titulo: 'Supermercado 3',
      nombre: 'Makro',
      colorPrimario: Color(0xFFE31E24),
      colorSecundario: Color(0xFFFFFFFF),
      colorTexto: Colors.white,
      slogan: 'Mayorista de Colombia',
    ),
    Supermercado(
      id: 'jumbo',
      imageUrl: 'assets/logo_jumbo.png',
      titulo: 'Supermercado 4',
      nombre: 'Jumbo',
      colorPrimario: Color(0xFF2E7D32),
      colorSecundario: Color(0xFFFFFFFF),
      colorTexto: Colors.white,
      slogan: 'Grandes momentos',
    ),
    Supermercado(
      id: 'ara',
      imageUrl: 'assets/logo_ara.png',
      titulo: 'Supermercado 5',
      nombre: 'Ara',
      colorPrimario: Color(0xFFFF6B35),
      colorSecundario: Color(0xFFFFFFFF),
      colorTexto: Colors.white,
      slogan: 'Cerca de ti',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 103,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: promociones.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // Navegar a la vista del supermercado con los datos específicos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupermarketDetailScreen(
                      supermercado: promociones[index],
                    ),
                  ),
                );
              },
              child: Container(
                width: 106,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  // Agregamos un efecto de sombra para mejor UX
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  promociones[index].imageUrl,
                  width: 85,
                  height: 85,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Widget de fallback si la imagen no se encuentra
                    return Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.store,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Pantalla de detalle del supermercado que cambia según la selección
class SupermarketDetailScreen extends StatelessWidget {
  final Supermercado supermercado;

  const SupermarketDetailScreen({
    Key? key,
    required this.supermercado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<Producto> productos = ProductosDatabase().obtenerProductosPorSupermercado(supermercado.id);
    final listaCategoriasPropias = CategoryData.obtenerCategoriasPorSupermercado(supermercado.id);

    return Scaffold(
      // AppBar personalizado con los colores del supermercado
      appBar: RoundedAppBar(title: supermercado.nombre,
        backgroundColor: supermercado.colorSecundario,
        buttonColor: supermercado.colorPrimario,
        textColor: supermercado.colorTexto,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchBarComponent(
              hintText: 'Buscar Productos...',
              backgroundColor: Colors.grey.shade100,
              borderColor: Color(0xFFD6D8D8),
              iconColor: Color(0xFF5BC0BE),
              onSearchChanged: (query) {
                print('Buscando: $query');
                // Aquí puedes manejar la lógica de búsqueda
              },
              onFilterPressed: () {
                print('Filter button pressed');
                // Aquí puedes manejar la lógica del filtro
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Promociones', style: TextStyle(fontSize: 15)),
                  Icon(Icons.more_horiz, color: Color(0xFF5BC0BE)),
                ],
              ),
            ),
            PromocionesCarrusel(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Categorias', style: TextStyle(fontSize: 15)),
                  Icon(Icons.more_horiz, color: Color(0xFF5BC0BE)),
                ],
              ),
            ),

            CategoryWidget(
              categorias: listaCategoriasPropias,
              onCategoryTap: (String categoriaSeleccionada) {
                // 1) Filtramos por esa categoría SOLO en este supermercado
                final productosFiltrados = ProductosDatabase()
                    .filtrarPorCategoria(supermercado.id, categoriaSeleccionada);

                // 2) Navegamos a ProductListScreen con título y lista filtrada
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(
                      title: '$categoriaSeleccionada en ${supermercado.nombre}',
                      productos: productosFiltrados,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  16.0),
              child: GridView.builder(
                shrinkWrap: true,                          // importante para que no intente hacer scroll propio
                physics: NeverScrollableScrollPhysics(),   // delega el scroll al SingleChildScrollView
                itemCount: productos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,       // 3 columnas
                  crossAxisSpacing: 6,    // espacio horizontal entre cards
                  mainAxisSpacing: 6,     // espacio vertical entre cards
                  childAspectRatio: 0.6,   // ajusta la altura/ancho de cada tarjeta
                ),
                itemBuilder: (context, index) {
                  final p = productos[index];
                  return ProductCard(
                    producto: p,
                    onAdd: () {
                      context.read<CartService>().addProduct(p);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${p.nombre} agregado al carrito'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildOptionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}