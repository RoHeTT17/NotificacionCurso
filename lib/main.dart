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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  //Se convirtio a StateFulWiget para poder usar el init state
  @override
  void initState() {
    super.initState();

    //Ya se tiene acceso al context
    PushNotificationService.getMessageStream.listen((message) {
       print('**********************MyApp: $message');

    //Cuando se recibe una notificación y se quiere navegar a otra pantalla (por como esta desrrollada esta app)
    //No se puede usar el Navigator.pushNamed, porque a este nivel aún no se crea el context.
    //Por eso se crean los GlobalKey

      navigatorKey.currentState?.pushNamed('message',arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      routes: {
        'home' : (context) => HomeScreen(),
        'message': (context) => MessageScreen()
      },

    );
  }
}