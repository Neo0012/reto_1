import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reto_deber/src/data/infrastructure/repository_photos_impl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Reto 1 ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff25282B),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "Reto 1 api",
                style: TextStyle(
                  color: Color(0xff25282B),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://static.wikia.nocookie.net/batman/images/9/9b/Bat_27.jpg/revision/latest/scale-to-width-down/732?cb=20130416234434&path-prefix=es',
                          width: 70,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'TAG',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff25282B),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Lo que describe el tag',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff25282B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 32,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      get();
                    },
                    child: const Text('Confirmar'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void get() async {
    await Permission.location.isGranted;
    // if (status.isDenied || status.isPermanentlyDenied) {
    //   // Abrir las configuraciones de la app para que el usuario manualmente
    //   // nos de permisos
    //   openAppSettings();
    //   return;
    // }

    final repository = RepositoryPhotosImpl();
    await repository.getDataPhotos();
  }
}
