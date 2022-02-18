
//SHA1: 54:8D:08:5B:8F:89:BB:AF:06:4D:7B:E4:0F:21:D3:03:D2:5F:16:DF

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  //Esta clase se maneja con metodos static para no necesitar de un gestor de estado

  //Obtner la instancia de Firebase que es parte de la configuración del archivo que instalamos
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  //Cuando la aplicación esta en la pila de apps
  static Future _onBackGroundHandler (RemoteMessage message) async{
      print('onBackGroundHandker ${message.messageId}');
  }
  //Esta terminada la app pero puede escuchar
  static Future _onMessageHandler (RemoteMessage message) async{
      print('_onMessageHandler ${message.messageId}');
  }
  //Esta abierta la app y el usuario la esta mirando
  static Future _onMessageOpenApp (RemoteMessage message) async{
      print('_onMessageOpenApp ${message.messageId}');
  }

  static Future initializeApp() async{
    //Push Notifications
     //Para obtner esta información se instalo el paquete de firebase_core
     await Firebase.initializeApp();
     token = await FirebaseMessaging.instance.getToken();

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackGroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notifications

  }


}