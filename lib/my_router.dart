import 'package:go_router/go_router.dart';
import 'package:online_shopping_app/admin/screens/add_product_screen.dart';
import 'package:online_shopping_app/home_screen.dart';

class MyRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          // Admin Screen
          GoRoute(
            path: 'products',
            builder: (context, state) {
              return const ProductScreen();
            },
          ),
        ],
      ),
    ],
  );
}
