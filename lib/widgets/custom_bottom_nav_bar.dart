// /lib/widgets/custom_bottom_nav_bar.dart

import 'package:flutter/material.dart';

/// Barra de navegación inferior personalizada con 5 íconos + labels,
/// donde el botón central (Lista) sobresale.
class CustomBottomNavBar extends StatelessWidget {
  /// Índice de la pestaña actualmente activa:
  /// 0 = Inicio, 1 = Comunidad, 2 = Lista (botón central), 3 = Favoritos, 4 = Menú
  final int selectedIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  // Altura de la parte oscura de la barra (sin contar el “extra” para labels)
  static const double _barHeight = 60.0;

  // Colores base (ajústalos si tu tema usa otros)
  static const Color _colorPrincipal = Color(0xFF0B132B);   // fondo oscuro
  static const Color _colorSecundario = Color(0xFF3A506B);  // color del botón “lista” y activo

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Agregamos +20 de alto para que quepan las etiquetas (labels) encima del fondo
      height: _barHeight + 5,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ──────────────────────────────────────────────────────
          // 1) Fondo oscuro que ocupa TODO el ancho y _barHeight de alto
          // ──────────────────────────────────────────────────────
          Positioned.fill(
            child: Container(
              color: _colorPrincipal,
            ),
          ),

          // ──────────────────────────────────────────────────────
          // 2) Fila horizontal de 5 “huecos”: [Inicio][Comunidad][—espacio—][Favoritos][Menú]
          //    Cada ícono lleva su label debajo.
          // ──────────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ─── Inicio (índice 0) ───
                GestureDetector(
                  onTap: () {
                    if (selectedIndex != 0) {
                      // Evitamos hacer push si ya estamos en Inicio
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        // Si selectedIndex==0, pintamos de secundario; si no, en blanco
                        color: (selectedIndex == 0) ? _colorSecundario : Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Inicio',
                        style: TextStyle(
                          color: (selectedIndex == 0) ? _colorSecundario : Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // ─── Comunidad (índice 1) ───
                GestureDetector(
                  onTap: () {
                    if (selectedIndex != 1) {
                      Navigator.pushReplacementNamed(context, '/comunidad');
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people_outline,
                        color: (selectedIndex == 1) ? _colorSecundario : Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Comunidad',
                        style: TextStyle(
                          color: (selectedIndex == 1) ? _colorSecundario : Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // ─── Espacio reservado para el botón “Lista” central ───
                const SizedBox(width: 60),

                // ─── Favoritos (índice 3) ───
                GestureDetector(
                  onTap: () {
                    if (selectedIndex != 3) {
                      Navigator.pushReplacementNamed(context, '/favoritos');
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: (selectedIndex == 3) ? _colorSecundario : Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Favoritos',
                        style: TextStyle(
                          color: (selectedIndex == 3) ? _colorSecundario : Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // ─── Menú (índice 4) ───
                GestureDetector(
                  onTap: () {
                    if (selectedIndex != 4) {
                      Navigator.pushReplacementNamed(context, '/menu');
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.menu,
                        color: (selectedIndex == 4) ? _colorSecundario : Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Menú',
                        style: TextStyle(
                          color: (selectedIndex == 4) ? _colorSecundario : Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ──────────────────────────────────────────────────────
          // 3) Botón circular “Lista” (índice 2) que sobresale 20px por encima
          // ──────────────────────────────────────────────────────
          Positioned(
            // Si el fondo mide _barHeight=60, con “- 40” consigue sobresalir 20px
            bottom: _barHeight - 50,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (selectedIndex != 2) {
                      Navigator.pushReplacementNamed(context, '/lista');
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      // Si la “Lista” está seleccionada, el círculo se pinta de blanco;
                      // si no, se pinta de colorSecundario
                      color: (selectedIndex == 2) ? Colors.white : _colorSecundario,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.list,
                      // Si está seleccionada, el ícono se pinta de colorSecundario, si no, de blanco
                      color: (selectedIndex == 2) ? _colorSecundario : Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                // Label “Lista” siempre en blanco (podrías cambiar si quisieras)
                const Text(
                  'Lista',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
