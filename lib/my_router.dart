import 'package:go_router/go_router.dart';
import 'package:online_shopping_app/admin/screens/category/all_categories_screen.dart';
import 'package:online_shopping_app/admin/screens/main_admin_screen.dart';
import 'package:online_shopping_app/admin/screens/products/all_products_screen.dart';
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
            path: 'adminHomeScreen',
            builder: (context, state) {
              return const MainAdminScreen();
            },
            routes: <RouteBase>[
              // Admin Screen
              GoRoute(
                path: 'allCategories',
                builder: (context, state) {
                  return const AllCategoriesScreen();
                },
                routes: <RouteBase>[
                  // Admin Screen
                  GoRoute(
                    path: 'allProducts',
                    builder: (context, state) {
                      return const AllProductsScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
