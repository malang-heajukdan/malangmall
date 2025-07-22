// lib/providers/item_provider.dart
import 'package:flutter/material.dart';

import '../models/item.dart';

// ChangeNotifier 기반의 ItemProvider 클래스입니다!
// 상품 리스트를 관리하고, 상품을 추가할 때마다 UI를 업데이트합니다.
class ItemProvider with ChangeNotifier {
  final List<Item> _items = []; // 1. 내부 데이터 저장소

  List<Item> get items => _items; // 2. 외부에서 읽기 전용 접근

// 아이템 추가
  void addItem(Item item) {
    _items.add(item);
    notifyListeners(); // 3. 상품 추가 시 UI 업데이트 알림
  }

// 아이템 삭제
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

// ID로 아이템 찾기
  Item getById(String id) => _items.firstWhere((item) => item.id == id);

  /// -------------------------
  /// ----여기는 가짜 데이터!!! ----
  ItemProvider() {
    //앱 시작 시 몇 개의 상품을 미리 추가
    _items.add(Item(
      id: 'mock_1',
      name: '말랑문어',
      description:
          '바다 속 귀염둥이 문어! 부드럽고 쫄깃한 식감으로 볶음, 숙회, 반찬까지 만능 요리재료예요. 오늘 저녁엔 문어 한 마리 어때요?',
      imagePath: 'lib/assets/images/octopus.png',
      price: 13900,
    ));
    _items.add(Item(
      id: 'mock_2',
      name: '대충 오징어',
      description:
          "이 오징어는 영국에서 시작되어 행운을 부르는 오징어입니다. 이 오징어를 구매하고 나서 일주일 내에 지인에게 추천하지 않을 시 오징어의 저주가 발생하여 머리가 오징어처럼 반짝일 것입니다. 이 신비로운 오징어는 먼 옛날, 일본의 작은 어촌 마을에서 발견되었습니다. 전설에 따르면, 이 오징어는 심해의 보물창고를 지키던 수호신이었으며, 특별한 사람들에게만 모습을 드러내어 행운을 가져다주었다고 합니다. 마을 사람들은 이 오징어를 '빛나는 오징어'라 부르며 숭배했고, 오징어의 기운을 받은 이들은 하는 일마다 순조롭게 풀리고 뜻밖의 횡재를 얻었다고 전해집니다. 하지만 이 오징어가 가져다주는 행운에는 한 가지 중요한 조건이 따릅니다. 이 오징어의 기운을 받아 행운을 누리게 된 사람은 반드시 일주일 안에 그 행운을 다른 소중한 사람과 나누어야 합니다. 만약 이 조건을 지키지 않고 오징어의 기운을 혼자 독차지하려 한다면, 오징어의 강력한 저주가 발동하여 머리카락이 오징어처럼 반짝이는 현상이 나타난다고 합니다. 처음에는 은은한 빛이었던 것이 시간이 지날수록 더욱 강렬해져, 밤에도 번쩍이는 오징어 머리가 된다는 섬뜩한 경고가 전해져 내려옵니다. 이 오징어의 힘은 오직 나눔을 통해 진정한 행운으로 완성된다는 메시지를 담고 있는 셈이죠. 당신은 이 빛나는 오징어의 행운을 잡고, 그 행운을 나눌 준비가 되셨나요?",
      imagePath: 'lib/assets/images/squid.png',
      price: 9500,
    ));
    _items.add(Item(
      id: 'mock_3',
      name: '광어광어',
      description: "오늘은 회 한 판 어때요? 숙성도 가능한 회용 광어! 말랑선장이 직접 고른 바다 속 프리미엄 귀족.",
      imagePath: 'lib/assets/images/domi.png',
      price: 17800,
    ));
    _items.add(Item(
      id: 'apolozi',
      name: '사과해요 나한테🍎',
      description:
          '만약 사과를 하려면 그쪽이 해야지, 나는 그쪽이 좋은데 그쪽은 내가 싫으니까, 싫어서 미안하다고 그쪽이 나한테 사과해야 되는 거 아니에요? 사과해요 나한테!',
      imagePath: 'lib/assets/images/apolozi.png',
      price: 0,
    ));

    _items.add(Item(
      id: 'mock_4',
      name: '가리비',
      description: '입 열면 달콤한 바다향! 구워먹고, 찜으로도 찰떡! 껍질까지 예쁜 가리비는 비주얼 맛집템입니다.',
      imagePath: 'lib/assets/images/galibi.png',
      price: 11000,
    ));
    _items.add(Item(
      id: 'mock_5',
      name: '뚠뚠 해삼',
      description: "말캉쫀득 해삼 등장! 탕으로도, 숙회로도 즐겨요. 바다 속 보양식으로 원기충전✨",
      imagePath: 'lib/assets/images/haesam.png',
      price: 14900,
    ));
  }

  Future<void> loadItems() async {}
}
