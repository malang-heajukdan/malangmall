import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/item_cart.dart';
import 'package:flutter_application_1/pages/item_detail2.dart';
import 'package:flutter_application_1/pages/item_list.dart';
import 'package:flutter_application_1/pages/item_register_v2.dart';
import 'package:flutter_application_1/pages/thumbnail_touch_page.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:flutter_application_1/provider/item_provider.dart';
import 'package:flutter_application_1/styles/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // 우리 provider는 item이랑 cart 두 개가 있으니
    // MultiProvider를 사용해서 여러 개의 provider를 등록해줍니당
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final testItem = context.read<ItemProvider>().items[3]; //mock item 2

    return MaterialApp(
      title: 'Shopping Mall',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const ThumbnailTouchPage( imagePath:'lib/assets/images/thumbnail_final.png'), 
        '/cart': (_) => const ItemCart(),        
        '/register': (_) => const ItemRegisterV2(),
        '/detail': (_) => ItemDetail2(item: testItem),
        '/list': (_) => const ItemList(),
        '/time_sale': (_) => const ThumbnailTouchPage( imagePath: 'lib/assets/images/time_sale.png'),
      },
    );
  }
}
