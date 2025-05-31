import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/promo_carrusel.dart';
import '../widgets/tools_component.dart';
import '../widgets/categories.dart';
import '../widgets/supermarkets.dart';
import '../widgets/searchbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 2, // Aumentamos la altura para acomodar mejor el componente
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

            CategoryWidget(),

            SizedBox(height: 16),
            
            ToolsComponent(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text('Supermercados', style: TextStyle(fontSize: 15)),
              ),
            ),
            
            SupermarketWidget(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Productos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lista'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
        selectedItemColor: Colors.teal[800],
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF0B132B),
      ),
      backgroundColor: Colors.white,
    );
  }
}
