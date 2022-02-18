import 'package:flutter/material.dart';
import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_screen.dart';
import 'package:notificaciones/services/push_notifications_service.dart';

// void main() => runApp(MyApp());
void main() async{

 //Los Widgets se deben inicializar antes de hacer una llamada (before the WidgetsFlutterBinding has been initialized.)
 //Para asegurarnos que cuando se inicialice el PushNotificationService.initializeApp, exista cuando menos listo un context
 WidgetsFlutterBinding.ensureInitialized();
 //Obtner datos del token
 await PushNotificationService.initializeApp();
 //iniciar app
 runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home' : (context) => HomeScreen(),
        'message': (context) => MessageScreen()
      },

    );
  }
}