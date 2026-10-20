import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/online_assistant_screen.dart';
import 'screens/order_history_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/for_you_screen.dart';
import 'screens/bouquet_detail_screen.dart';
import 'screens/flower_detail_screen.dart';
import 'screens/create_bouquet_screen.dart';
import 'screens/login_form_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/choose_situation_screen.dart';
import 'screens/choose_favorites_screen.dart';
import 'screens/result_screen.dart';
import 'screens/address_screen.dart';

void main() {
  runApp(const FlowerShopApp());
}

class FlowerShopApp extends StatelessWidget {
  const FlowerShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower Shop',
      builder: (context, child) {
        final scale = MediaQuery.of(context).size.width / 390;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(scale.clamp(0.8, 1.5)),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFDF8),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/login-form': (_) => const LoginFormScreen(),
        '/registration': (_) => const RegistrationScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/favorites': (_) => const FavoritesScreen(),
        '/assistant': (_) => const OnlineAssistantScreen(),
        '/orders': (_) => const OrderHistoryScreen(),
        '/cart': (_) => const CartScreen(),
        '/foryou': (_) => const ForYouScreen(),
        '/create': (_) => const CreateBouquetScreen(),
        '/choose-situation': (_) => const ChooseSituationScreen(),
        '/address': (_) => const AddressScreen(),
        '/choose-favorites': (_) => const ChooseFavoritesScreen(),
        '/result': (ctx) {
          final args = ModalRoute.of(ctx)?.settings.arguments;
          final map = (args is Map) ? args : <String, dynamic>{};
          return ResultScreen(
            title: (map['title'] as String?) ?? 'your bouquet',
            size: (map['size'] as int?) ?? 15,
            liked: ((map['liked'] as List?) ?? const []).cast<String>(),
          );
        },
        '/detail': (ctx) {
          final args = ModalRoute.of(ctx)?.settings.arguments;
          final map = (args is Map) ? args : <String, dynamic>{};
          return BouquetDetailScreen(
            title: (map['title'] as String?) ?? 'Bouquet',
            description: (map['description'] as String?) ?? '',
            price: (map['price'] as String?) ?? '',
            image: (map['image'] as String?) ??
                'assets/images/bouquet_8th_march.png',
          );
        },
        '/flower': (ctx) {
          final args = ModalRoute.of(ctx)?.settings.arguments;
          final map = (args is Map) ? args : <String, dynamic>{};
          return FlowerDetailScreen(
            title: (map['title'] as String?) ?? 'Flower',
            description: (map['description'] as String?) ?? '',
            price: (map['price'] as String?) ?? '',
            image: (map['image'] as String?) ?? 'assets/images/cat_gerbera.png',
          );
        },
      },
    );
  }
}
