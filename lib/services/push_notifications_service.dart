
//SHA1: 54:8D:08:5B:8F:89:BB:AF:06:4D:7B:E4:0F:21:D3:03:D2:5F:16:DF

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  //Esta clase se maneja con metodos static para no necesitar de un gestor de estado

  //Obtner la instancia de Firebase que es parte de la configuración del archivo que instalamos
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();

  static Stream<String> get getMessageStream => _messageStream.stream;

  //Cuando la aplicación esta en la pila de apps
  static Future _onBackGroundHandler (RemoteMessage message) async{
      // print('onBackGroundHandler ${message.messageId}');
      print(message.data);
      // _messageStream.add(message.notification?.title?? 'No title');
       _messageStream.add(message.data['producto']??'No Data');
  }
  //Esta abierta la app y el usuario la esta mirando
  static Future _onMessageHandler (RemoteMessage message) async{
      // print('_onMessageHandler ${message.messageId}');

      print(message.data);
      // _messageStream.add(message.notification?.body?? 'No title');
      _messageStream.add(message.data['producto']??'No Data');
  }
  //Esta terminada la app pero puede escuchar
  static Future _onMessageOpenApp (RemoteMessage message) async{
      // print('_onMessageOpenApp ${message.messageId}');
      print(message.data);
      // _messageStream.add(message.notification?.title?? 'No title');
      _messageStream.add(message.data['producto']??'No Data');
 
 
  }

  static Future initializeApp() async{
    //Push Notifications
     //Para obtner esta información se instalo el paquete de firebase_core
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    print('token: $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackGroundHandler);
    //Esta abierta la app
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notifications

  }

  static closeStreams(){
    //Se pone esta linea porque se debe indicar cuando menos el código de cerrar el StreamController, en este
    //tipo de caso nunca se va a cerrar, pero debe estar la línea de código.
    _messageStream.close();
  }


}