import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> products = [
    //판매하는 상품목록
    Product('shirt', 45000),
    Product('onepiece', 30000),
    Product('T-shirt', 35000),
    Product('pants', 38000),
    Product('socks', 5000), // 깔끔하게 정리 하는 방법이 없을까
  ];
  List<Product> cart = []; // 장바구니

  ShoppingMall();

  void printAll() {
    // 판매하는 상품 목록을 보여주기
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  void addProduct(String productName, int productCount) {
    if (productCount <= 0) {
      //0개 이하의 상품을 담으려 할 경우
      print('0개보다 많은 개수의 상품만 담을 수 있어요!');
      return;
    }
    List target = products.where((p) {
      return p.name == productName;
    }).toList(); // 상품 목록에 존재하지 않는 상품을 입력한 경우
    if (target.isEmpty) {
      print('입력값이 올바르지 않아요!');
      return;
    }
    Product product = target[0];
    for (var i = 0; i < productCount; i++) {
      cart.add(product);
    }
    print('${product.name}이 ${productCount}개 담겼습니다!');
  }

  int totalPrice() {
    int total = 0;
    for (var i = 0; i < cart.length; i++) {
      total += cart[i].price;
    }
    return total;
  }
}

void main() {
  //1,2,3,4 입력기능 구현
  var mall = ShoppingMall();

  while (true) {
    print(
        '--------------------------------------------------------------------------------------------------------');
    print(
        '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
    print(
        '--------------------------------------------------------------------------------------------------------');

    String? userInput = stdin.readLineSync(); //스위치 문을 통해 입력 받고 각 숫자에 기능 할당해주기
    if (userInput != null) {
      switch (userInput) {
        case '1': //상품 목록 보여주기
          mall.printAll();
          break;
        case '2': // 장바구니 담기 기능
          print('상품 이름을 입력해 주세요 !');
          String? productName = stdin.readLineSync();

          print('상품 갯수를 입력해 주세요 !');
          String? productCountStr = stdin.readLineSync();

          try {
            int productCount = int.parse(productCountStr!);
            mall.addProduct(productName!, productCount);
          } catch (e) {
            print('정확한 갯수를 입력해주세요.');
          }
        case '3': // 장바구니 총 가격보기
          print('장바구니에 ${mall.totalPrice()}원 어치를 담으셨네요');
          break;
        case '4': //프로그램 종료
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
          return;
        default:
          print('지원하지 않는 기능입니다! 다시 시도해주세요');
      }
    }
  }
}
