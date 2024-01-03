import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/app/routes/router.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xff1a55ce),
          chipTheme: ChipThemeData(
            showCheckmark: false,
            surfaceTintColor: Colors.white,
            color: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xff3b77f8);
                }
                return const Color(0xffe6effd);
              },
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Color(0xffb7cefe),
              ),
            ),
          ),
        ),
        builder: (context, child) => child!,
      ),
    );
  }
}
