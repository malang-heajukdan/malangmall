import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/item_cart.dart';
import 'package:flutter_application_1/pages/item_detail2.dart';
import 'package:flutter_application_1/pages/item_list.dart';
import 'package:flutter_application_1/pages/item_register.dart';
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
      themeMode: ThemeMode.light,
      theme: lightTheme,
      // darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      // home: const ItemRegister()); // 영민 테스트용!
      // home: ItemDetail2(item: testItem)); // 소린 테스트용!
      //home: const ItemList()); //초희 테스트
      // 초희님까지 끝나면!! 아래코드로 실행해주기!
      // home: const ItemList(),
      initialRoute: '/',
      routes: {
        '/cart': (_) => const ItemCart(),
        '/': (_) => const ThumbnailTouchPage(), // 초기화면 입력이 필요합니다.
        '/register': (_) => const ItemRegister(),
        '/detail': (_) => ItemDetail2(item: testItem),
        '/list': (_) => const ItemList(),
      },
    );

    // home: ThumbnailTouchPage()); // 썸네일 터치 페이지로 시작
  }
}
