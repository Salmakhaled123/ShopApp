class Carts {
  bool ?status;
  DataCart ? data;
  Carts.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ?
    DataCart.fromJson(json['data']) : null;
  }

}

class DataCart {
  List<CartItems> cartItems=[];
  int ?subTotal;
  int ?total;

  DataCart.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {

      json['cart_items'].forEach((v) {
        cartItems.add( CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }


}

class CartItems {
  int ?id;
  int ?quantity;
  ProductCart ?product;
  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ?  ProductCart.fromJson(json['product']) : null;
  }


}

class ProductCart {
  int ?id;
  String? image;
  String ?name;
  dynamic price;
  ProductCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price=json['price'];

  }


}
