import 'package:flutter/material.dart';

// Primero, vamos a crear un modelo para representar tus promociones/imágenes
class Categoria {
  final String imageUrl; // URL de la imagen
  final String titulo;

  Categoria({required this.imageUrl, required this.titulo});
}

// En tu widget, crea una lista con tus promociones
class CategoryWidget extends StatelessWidget {
  // Esta lista la puedes obtener de una API, base de datos, etc.
  final List<Categoria> promociones = [
    Categoria(imageUrl: 'assets/cat_aseo.png', titulo: 'Categoria 1'),
    Categoria(imageUrl: 'assets/cat_personal.png', titulo: 'Categoria 2'),
    Categoria(imageUrl: 'assets/cat_snack.png', titulo: 'Categoria 3'),
    Categoria(imageUrl: 'assets/cat_lacteos.png', titulo: 'Categoria 4'),
    Categoria(imageUrl: 'assets/cat_bebidas.png', titulo: 'Categoria 5'),
    Categoria(imageUrl: 'assets/cat_personal.png', titulo: 'Categoria 6'),
    Categoria(imageUrl: 'assets/cat_aseo.png', titulo: 'Categoria 7'),
    Categoria(imageUrl: 'assets/cat_snack.png', titulo: 'Categoria 8'),
    // Añade más según necesites
  ];

@override
Widget build(BuildContext context) {
  return SizedBox(
    height: 62,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: promociones.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Container(
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            alignment: Alignment.center,       // Centra al hijo
            child: Image.asset(
              promociones[index].imageUrl,
              width: 32,
              height: 35,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    ),
  );
}
}