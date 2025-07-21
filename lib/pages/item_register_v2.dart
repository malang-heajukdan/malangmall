import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/provider/item_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ItemRegisterV2 extends StatefulWidget {
  const ItemRegisterV2({super.key});

  @override
  State<ItemRegisterV2> createState() => _ItemRegisterV2();
}

class _ItemRegisterV2 extends State<ItemRegisterV2> {
  // 텍스트 필드 컨트롤러
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();

  // 라이브러리용
  File? _image;
  final uuid = const Uuid();

  // 이미지 피커
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  // State 호출
  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    priceController.addListener(() {
      setState(() {});
    });
  }

  // 빌드 - * 레이아웃 디자인 나오면 맞춰서 수정해야함 *
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add My Product"),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Stack(
        children: [
          //selectImage(),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Positioned(
                left: 0,
                top: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selectImage(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
                            child: itemText("Name"),
                          ),
                          Row(
                            children: [
                              Expanded(child: nameTextField()),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 21, 10, 0),
                            child: itemText("Price(\$)"),
                          ),
                          Row(
                            children: [
                              Expanded(child: priceTextField()),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 21, 10, 0),
                              child: itemText("Description"),
                            ),
                          ),
                          Expanded(child: descriptionTextField()),
                          registerBotton(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 사진 선택
  GestureDetector selectImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 240,
          width: double.infinity,
          color: Theme.of(context).colorScheme.tertiary,
          child: _image == null
              ? const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "사진 선택",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Image.file(_image!, fit: BoxFit.cover),
        ),
      ),
    );
  }

  // 상품 정보 텍스트 디자인
  Widget itemText(String iteminfo) {
    return Text(
      iteminfo,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // 상품 이름 텍스트 필드
  Padding nameTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
      child: TextFormField(
        controller: nameController,
        style: const TextStyle(
          fontSize: 12,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "상품 이름은 비워둘 수 없습니다.";
          }
          return null;
        },
        cursorColor: Colors.white,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: borderDecoration("상품 이름을 입력해주세요."),
      ),
    );
  }

  // 상품 가격 텍스트 필드
  Widget priceTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
      child: TextFormField(
        controller: priceController,
        style: const TextStyle(fontSize: 12),
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        inputFormatters: [
          DollarInputFormatter(),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "상품 가격은 비워둘 수 없습니다.";
          }
          if (value.startsWith("\$0.00")) {
            return "상픔 가격은 0으로 시작할 수 없습니다.";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: borderDecoration("상품 가격을 입력해주세요.(단위:달러 예:12.34)"),
      ),
    );
  }

  // 상품 설명 텍스트 필드
  Widget descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
      child: SizedBox(
        height: 150,
        child: TextFormField(
          controller: descriptionController,
          style: const TextStyle(fontSize: 12),
          cursorColor: Colors.white,
          minLines: 8,
          maxLines: null,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "상품 설명은 비워둘 수 없습니다.";
            }
            return null;
          },
          decoration: borderDecoration("상품 설명을 입력해주세요."),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }

  // 보더 속성
  InputDecoration borderDecoration(String guideText) {
    return InputDecoration(
      hintText: guideText,
      filled: true,
      fillColor: Theme.of(context).colorScheme.primary,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.3,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: const BorderSide(color: Color.fromARGB(255, 255, 186, 209)),
      ),
    );
  }

  // 버튼 활성화 조건
  bool isPossibleRegister() {
    return (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        _image != null);
  }

  double cleanPrice(String text) {
    // 쉼표 제거 → "1,234.56" → "1234.56"
    String cleaned = text.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  // 상품 데이터 전달
  Item _submitForm() {
    String id = uuid.v4();

    final newItem = Item(
      id: id,
      name: nameController.text,

      price: int.parse(priceController.text.replaceAll(",", "")),
      imagePath: _image!.path,
      description: descriptionController.text,
    );
    return newItem;
  }

  // 등록하기 버튼
  Widget registerBotton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
            width: double.infinity,
            height: 56,
            child: IgnorePointer(
              ignoring: !isPossibleRegister(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isPossibleRegister()
                        ? const Color(0xFF95c5d4)
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text(
                  "등록하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  final itemProvider =
                      Provider.of<ItemProvider>(context, listen: false);
                  itemProvider.addItem(_submitForm());

                  // 등록 완료 팝업
                  showDialogPopup();
                },
              ),
            )),
      ),
    );
  }

  // 등록 완료 팝업
  Future<dynamic> showDialogPopup() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        // 타이틀
        title: const Row(
          children: [
            Text(
              "등록 완료",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // 내용
        content: const Text(
          "상품이 등록되었습니다.",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 팝업 닫기
              Navigator.of(context).pop(); // 등록 페이지 닫기
            },
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,

                backgroundColor: const Color(0xFF95c5d4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: const Text("확인"),
          )
        ],
      ),
    );
  }
}

// 상품 가격 텍스트 필드 포매터
class DollarInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter =
      NumberFormat.currency(locale: "en_US", symbol: "\$");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {

      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    double value = double.parse(digitsOnly) / 100;
    final newText = _formatter.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
