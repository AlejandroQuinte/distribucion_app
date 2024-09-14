import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: size.width,
            height: size.height,
            child: const Center(
              child: Text('Cargando...',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
            ),
          ), // Puedes cambiar esto por cualquier widget de carga
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
