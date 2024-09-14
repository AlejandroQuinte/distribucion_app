import 'package:flutter/material.dart';

onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const AlertDialog(
      title: Text('Cargando'),
      content: LinearProgressIndicator(),
    ),
  );
}

onShowLoading(BuildContext context, bool isLoading) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) => const Center(
      child: CircularProgressIndicator(),
    ),
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, anim1, anim2, child) => Transform.scale(
      scale: anim1.value,
      child: Opacity(
        opacity: anim1.value,
        child: child,
      ),
    ),
  );
}
