import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register.dart';
import 'package:go_router/go_router.dart';

import '../screens/login.dart';

class AppRouter {
  static String loginPath = '/loginPath';
  static String registerPath = '/registerPath';
  static String chatPath = '/chatPath';
  static String forgetPasswordWithMail = '/forgetPasswordWithMail';

  static GoRouter router = GoRouter(
    initialLocation: loginPath,
    routes: [
      GoRoute(
        path: loginPath,
        builder: (context, state) =>  Login(),
      ), GoRoute(
        path: registerPath,
        builder: (context, state) =>  Register(),
      ),GoRoute(
        path: chatPath,
        builder: (context, state) =>  ChatPage(),
      ),
     
    ],
  );
}
