import 'package:distribucion_app/presentation/widgets/page_wrapper.dart';
import 'package:distribucion_app/presentation/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class PageLayoutScreen extends StatelessWidget {
  const PageLayoutScreen({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(title: Text(title)),
        body: child,
      ),
    );
  }
}
