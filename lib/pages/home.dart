import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddeliveryapp/pages/details.dart';
import 'package:fooddeliveryapp/pages/services/database.dart';
import '../widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  Stream? foodItemStream;
  ontheload () async{
    foodItemStream = await DatabaseMethods.getFoodItem("Pizza");
    setState(() {

    });
  }

  Widget allItemVertically() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot){
          return snapshot.hasData? ListView.builder(
              padding:EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"])));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10,bottom: 20),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(
                                    ds["Name"],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(
                                    ds["Detail"],
                                    style: AppWidget.lightTextFieldStyle(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(
                                    "\$"+ds["Price"],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }):const Center(child: CircularProgressIndicator());
        });
  }

  Widget allItem() {
    return StreamBuilder(
        stream: foodItemStream,
        builder: (context, AsyncSnapshot snapshot){
          return snapshot.hasData? ListView.builder(
              padding:EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"])));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              ds["Name"],
                              style: AppWidget.semiBoldTextFieldStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              ds["Detail"],
                              style: AppWidget.lightTextFieldStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text("\$" + ds["Price"],
                              style: AppWidget.semiBoldTextFieldStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }):const Center(child: CircularProgressIndicator());
        });
  }
  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello Viet', style: AppWidget.boldTextFieldStyle()),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.black),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text('Delicious Food', style: AppWidget.headLineTextFieldStyle()),
              Text('Discover and Get Greate Food',
                style: AppWidget.lightTextFieldStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.only(right: 20), child: showItem()),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 270,
                  child: allItem()
              ),
              const SizedBox(height: 20,),
              allItemVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            foodItemStream = await DatabaseMethods.getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/ice-cream.png",
                height: 48,
                width: 50,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            foodItemStream = await DatabaseMethods.getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                height: 48,
                width: 50,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            foodItemStream = await DatabaseMethods.getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/salad.png",
                height: 48,
                width: 50,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            foodItemStream = await DatabaseMethods.getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5.8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                height: 48,
                width: 50,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
