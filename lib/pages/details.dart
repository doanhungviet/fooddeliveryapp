import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/services/database.dart';
import 'package:fooddeliveryapp/pages/services/shared_pref.dart';
import 'package:fooddeliveryapp/widgets/widget_support.dart';

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
      {required this.detail,
        required this.image,
        required this.name,
        required this.price});


  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1,total =0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total =int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (a > 1) {
                    --a;
                    total = total - int.parse(widget.price);
                  }
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                a.toString(),
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  ++a;
                  total = total + int.parse(widget.price);
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Text(
           widget.detail,
            maxLines: 3,
            style: AppWidget.lightTextFieldStyle(),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                "Delivery Time",
                style: AppWidget.semiBoldTextFieldStyle(),
              ),
              const SizedBox(
                width: 25,
              ),
              const Icon(
                Icons.alarm,
                color: Colors.black54,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "30 mins",
                style: AppWidget.semiBoldTextFieldStyle(),
              )
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                    Text(
                      "\$"+total.toString(),
                      style: AppWidget.headLineTextFieldStyle(),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    if (id != null) {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };
                      await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Food Added to Cart",
                            style: TextStyle(fontSize: 18.0),
                          )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            "Failed to add food to cart. User ID is null.",
                            style: TextStyle(fontSize: 18.0),
                          )));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Add to card",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
