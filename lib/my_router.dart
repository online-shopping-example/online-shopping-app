import 'package:go_router/go_router.dart';
import 'package:online_shopping_app/admin/screens/admin_home_screen.dart';
import 'package:online_shopping_app/home_screen.dart';

import 'admin/screens/category/all_categories_screen.dart';
import 'admin/screens/products/all_products_screen.dart';

class MyRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/AdminHomeScreen',
            builder: (context, state) {
              return const AdminHomeScreen();
            },
          ),
          // Admin Screen
          GoRoute(
            path: '/AllCategory',
            builder: (context, state) {
              return const AllCategoriesScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/AllProducts',
        builder: (context, state) {
          return const AllProductsScreen();
        },
      ),
    ],
  );
}
