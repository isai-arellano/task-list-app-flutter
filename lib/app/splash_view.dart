import 'package:curso_flutter/app/ui/components/h1_title.dart';
import 'package:curso_flutter/app/ui/components/shape.dart';
import 'package:curso_flutter/app/ui/home/inherited_widgets.dart';
import 'package:curso_flutter/app/ui/task_list/task_list_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          _HeaderSplashView()
      ]),
    );
  }
}

class _HeaderSplashView extends StatelessWidget {
  const _HeaderSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const Row(children: [ShapeCircle()],),
                Column(
                  children: [
                    const SizedBox(height: 180),
                    Image.asset('assets/images/onboarding-image.png', width: 180, height: 168),
                    const SizedBox(height: 99),
                    const H1Title('Lista de Tareas'),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const TaskListView()));
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                            textAlign: TextAlign.center,
                            ),
                        ),
                      ),
                    )
                  ],
                )
              ],
               ),
          );
  }
}