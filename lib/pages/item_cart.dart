import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCart extends StatefulWidget {
final Map<String, dynamic>? newItem;

const ItemCart({super.key, this.newItem});

    @override
  State<ItemCart> createState() => _ItemCartState();
}
class _ItemCartState extends State<ItemCart> {
  List<Map<String, dynamic>> cartItems =[
    {'name': '대충 문어', 'price': 15000, 'quantity': 2},
      {'name': '대충 오징어', 'price': 30000, 'quantity': 1},
  ];
// 상세페이지에서 넘어온 상품 추가
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
  // 삭제 기능 1
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  } 

  @override
  Widget build(BuildContext context) {
        final bool isCartEmpty = cartItems.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      // 상단 AppBar 만들기
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text('장바구니'),
      ),

      body: cartItems.isEmpty
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
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 상품 정보
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('${item['price']}원'),
                              ],
                            ),
                            // 수량 표시
                             Row(
                              children: [
                                IconButton(
                                  // - 버튼: 수량 감소 
                                  onPressed: () {
                                    setState(() {
                                     if (item['quantity'] > 1) {
                                      item['quantity']--;
                                    }
                                  });
                                }, 
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                                Text('${item['quantity']}'), // 현재 수량 표시하기
                                IconButton(
                                  // + 버튼: 수량 증가 기능
                                  onPressed: () {
                                    setState(() {
                                      item['quantity']++;
                                    });
                                  }, 
                                  icon: Icon(Icons.add_circle_outline),
                                ),
                              ],
                             ),
                             // 삭제 기능 2
                             Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () => removeItem(index), 
                                icon: Icon(Icons.delete_outline, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        
                      );
                    },
                  ),
                ),

                // 하단 버튼 영역
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SafeArea(
                    child: Center(
                      child: Text(
                        '구매하기',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
