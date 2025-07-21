import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/app_colors.dart';

class ItemCart extends StatefulWidget {
  final Map<String, dynamic>? newItem;

  const ItemCart({super.key, this.newItem});

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  List<Map<String, dynamic>> cartItems = [];
  // 상세페이지에서 넘어온 상품 추가하기
  @override
  void initState() {
    super.initState();
    if (widget.newItem != null) {
      cartItems.add({
        'images': widget.newItem!['images'],
        'name': widget.newItem!['name'],
        'price': widget.newItem!['price'],
        'quantity': widget.newItem!['quantity'] ?? 1,
      });
    }
  }

  // 삭제 기능
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // 총 가격 계산 함수
  int getTotalPrice() {
    int total = 0;
    for (var item in cartItems) {
      total += (item['price'] * item['quantity']) as int;
    }
    return total;
  }

  @override //화면구성
  Widget build(BuildContext context) {
    final bool isCartEmpty = cartItems.isEmpty;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/cart_bg.png',
          height: screenHeight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // 상단 AppBar 만들기
          appBar: AppBar(
            title: Text(
              'Cart',
              style: GoogleFonts.notoSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface, // 커스텀 컬러 사용
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.home_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, '/list'); // 장바구니 페이지 이동
                },
                color: AppColors.onSurface,
              ),
            ],
            backgroundColor: Colors.transparent, // 커스텀 컬러 사용
          ),

          body: Stack(
            children: [
              isCartEmpty
                  ? Center(
                      child: Text(
                        '장바구니가 비었습니다.',
                        style: GoogleFonts.notoSans(
                            fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];

                              return Container(
                                // 카드 스타일
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFFD3E6EC),
                                      width: 2.5),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey, //왜 선이 그어져있을까요?
                                      offset: Offset(2, 2),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 상품 이미지

                                    Padding(
                                      // 이미지 불러오기 방법1
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Image.asset(
                                          'lib/assets/images/octopus.png',

                                          fit: BoxFit
                                              .cover, // 또는 contain, fill 등도 사용 가능
                                        ),
                                      ),
                                    ),

                                    // Container( // 이미지 불러오기 방법2
                                    //   width: 120,
                                    //   height: 120,
                                    //   decoration: BoxDecoration(
                                    //     image: DecorationImage(
                                    //       image:
                                    //           AssetImage('assets/images/octopus.png'),
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //     borderRadius: BorderRadius.circular(8),
                                    //   ),
                                    // ),

                                    const SizedBox(width: 12),
                                    Expanded(
                                      //중간
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '₩${item['price']}',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF95C5D4)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      //오른쪽
                                      //삭제버튼
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () => removeItem(index),
                                          icon: const Icon(Icons.clear,
                                              color: Color(0xFF95C5D4)),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (item['quantity'] > 1) {
                                                    item['quantity']--;
                                                  }
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                color: Color(0xff95C5D4),
                                                size: 40,
                                              ),
                                            ),
                                            Text(
                                              '${item['quantity']}',
                                              style: GoogleFonts.notoSans(
                                                  fontSize: 18),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  item['quantity']++;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add_circle,
                                                color: Color(0xff95C5D4),
                                                size: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // 하단 버튼
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          decoration: const BoxDecoration(
                            color: Color(0xFF95C5D4),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: SafeArea(
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          '총 가격',
                                          style: GoogleFonts.notoSans(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '₩${getTotalPrice()}',
                                        style: GoogleFonts.notoSans(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('구매 완료'),
                                          content:
                                              const Text('구매가 성공적으로 완료되었습니다.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Center(
                                                child: Text(
                                                  '확인',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '구매하기',
                                      style: GoogleFonts.notoSans(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
