// /lib/widgets/tools_component.dart

import 'package:flutter/material.dart';
import 'package:deal/screens/map_screen.dart';  // Asegúrate de usar la ruta correcta

class ToolsComponent extends StatefulWidget {
  @override
  _ToolsComponentState createState() => _ToolsComponentState();
}

class _ToolsComponentState extends State<ToolsComponent> {
  int _selectedIndex = 0;
  final List<String> _tabs = ['Top 10', 'Descuentos', 'Nuevos'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------
        // 1) Pestañas (Top 10, Descuentos, Nuevos)
        // ------------------------
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFFABD1D1), width: 1.5),
          ),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              return _buildTabButton(_tabs[index], _selectedIndex == index, index);
            }),
          ),
        ),

        // ------------------------
        // 2) Título “Herramientas”
        // ------------------------
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Herramientas',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),

        // ------------------------
        // 3) Fila con “Mapa” y “Scanner”
        // ------------------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Envolvemos solo el bloque “Mapa” en GestureDetector para navegación
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navegar a MapScreen cuando el usuario pulse “Mapa”
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MapScreen()),
                    );
                  },
                  child: _buildToolContainer('Mapa', 'assets/tools_map.png'),
                ),
              ),
              const SizedBox(width: 16),
              // Scanner puede quedarse sin onTap por ahora, o implementarlo a tu gusto
              Expanded(
                child: _buildToolContainer('Scanner', 'assets/tools_scan.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String text, bool isSelected, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: isSelected ? const Color(0xFFD7EFEF) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFABD1D1),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolContainer(String title, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFABD1D1), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título arriba a la izquierda
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          // Espaciador que empuja la imagen hacia abajo
          const Expanded(child: SizedBox()),
          // Imagen abajo a la derecha
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  color: const Color(0xFF84B9BD),
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback si no existe el asset
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        title == 'Mapa' ? Icons.map : Icons.qr_code_scanner,
                        size: 30,
                        color: const Color(0xFF84B9BD),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
