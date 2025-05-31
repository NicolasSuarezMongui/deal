import 'package:flutter/material.dart';

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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5.0),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Color(0xFFABD1D1), width: 1.5),
          ),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              return _buildTabButton(_tabs[index], _selectedIndex == index, index);
            })
          ),
        ),

        Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text('Herramientas', style: TextStyle(fontSize: 15)),
              ),
            ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: _buildToolContainer('Mapa', 'assets/tools_map.png'),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildToolContainer('Scanner', 'assets/tools_scan.png'),
              ),
            ],
          )
        ),
      ]
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
            color: isSelected ? Color(0xFFD7EFEF) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFFABD1D1),
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
      padding: EdgeInsets.all(6),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFABD1D1), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título arriba a la izquierda
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          // Espaciador que empuja la imagen hacia abajo
          Expanded(child: SizedBox()),
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
                  color: Color(0xFF84B9BD), // Aplica el mismo color que tenían los iconos CustomPaint
                  errorBuilder: (context, error, stackTrace) {
                    // Widget de fallback en caso de que la imagen no se encuentre
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
                        color: Color(0xFF84B9BD),
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
