import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  final String hintText;
  final Function(String)? onSearchChanged;
  final VoidCallback? onFilterPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? hintColor;

  const SearchBarComponent({
    Key? key,
    this.hintText = 'Buscar Productos...',
    this.onSearchChanged,
    this.onFilterPressed,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.hintColor,
  }) : super(key: key);

  @override
  _SearchBarComponentState createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.borderColor ?? Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icono de búsqueda
          Icon(
            Icons.search,
            color: widget.iconColor ?? Colors.grey[600],
            size: 24,
          ),
          SizedBox(width: 12),
          
          // Campo de texto
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: TextStyle(
                color: widget.textColor ?? Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: widget.hintColor ?? Colors.grey[500],
                  fontSize: 16,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Botón de filtro
          GestureDetector(
            onTap: widget.onFilterPressed,
            child: Container(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.tune,
                color: widget.iconColor ?? Colors.grey[600],
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}