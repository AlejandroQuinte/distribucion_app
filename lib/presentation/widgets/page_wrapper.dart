import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;

  const PageWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final gecubit = context.read<GlobalErrorCubit>();

    return BlocListener<GlobalErrorCubit, GlobalErrorState>(
      listener: (context, state) async {
        if (state.hasError) {
          await ScaffoldMessenger.of(context)
              .showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 1),
                ),
              )
              .closed
              .then((_) => gecubit.clearError());
        }
      },
      child: BlocBuilder<GlobalLoadingCubit, GlobalLoadingState>(
        builder: (context, state) {
          return Stack(
            children: [
              child,
              if (state.loading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: LoadingIndicator(
                      indicatorType: Indicator.pacman,
                      colors: [Colors.blueAccent, Colors.purpleAccent],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
