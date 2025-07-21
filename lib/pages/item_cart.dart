import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCart extends StatefulWidget {
  final Map<String, dynamic>? newItem;

  const ItemCart({super.key, this.newItem});

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  List<Map<String, dynamic>> cartItems = [
    {'name': '대충 문어', 'price': 15000, 'quantity': 2},
    {'name': '대충 오징어', 'price': 30000, 'quantity': 1},
  ];
  // 상세페이지에서 넘어온 상품 추가하기
  @override
  void initState() {
    super.initState();
    if (widget.newItem != null) {
      cartItems.add({
        'name': widget.newItem!['name'],
        'price': widget.newItem!['price'],
        'quantity': 1,
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

  @override
  Widget build(BuildContext context) {
    final bool isCartEmpty = cartItems.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      // 상단 AppBar 만들기
      appBar: AppBar(
        title: Text(
          '장바구니',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),

      body: isCartEmpty
          ? Center(
              child: Text(
                '장바구니가 비었습니다.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xFFD3E6EC), width: 2.5),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: Offset(2, 2),
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 상품 이미지
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              // child: Image.asset(
                              //   'assets/images/apolozi.jpeg',
                              //   width: 80,
                              //   height: 80,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    '₩${item['price']}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => removeItem(index),
                                  icon: Icon(Icons.delete_outline,
                                      color: Colors.red),
                                ),
                                SizedBox(height: 8),
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
                                      icon: Icon(Icons.remove_circle_outline),
                                    ),
                                    Text(
                                      '${item['quantity']}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          item['quantity']++;
                                        });
                                      },
                                      icon: Icon(Icons.add_circle_outline),
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
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '총 가격',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '₩${getTotalPrice()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('구매 완료'),
                                  content: Text('구매가 성공적으로 완료되었습니다.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('확인'),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              '구매하기',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
//이미지 수정하기, 상세페이지와 연동하기, 아이콘 수정, 하단버튼 수정, 앱바와 카드목록 간격 수정, 어 뒤로가기 어디있지?
