import 'package:carousel_slider/carousel_slider.dart';
import 'package:dummy_api/api_service/http_service.dart';
import 'package:dummy_api/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsDetail extends StatelessWidget {
  const ItemsDetail({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade500,
          title: const Text('Products Detail'),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: FutureBuilder<Products>(
            future: fetchItemId(id: id),
            builder: (BuildContext context, AsyncSnapshot<Products> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final product = snapshot.data!;
                int _current = 0;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    CarouselSlider(
                      items: product.images
                          ?.map((item) => Center(
                              child: Image.network(item,
                                  fit: BoxFit.fill, width: 1000)))
                          .toList(),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.40,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        aspectRatio: 2.0,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        viewportFraction: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: product.images!.asMap().entries.map((entry) {
                        return GestureDetector(
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Description:",
                        style: GoogleFonts.roboto(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.description!,
                        style: GoogleFonts.roboto(
                            fontSize: 13.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Price:",
                        style: GoogleFonts.roboto(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '\$ ${product.price.toString()}',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Category:",
                        style: GoogleFonts.roboto(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.category!,
                        style: GoogleFonts.roboto(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Title:",
                        style: GoogleFonts.roboto(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.title!,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Brand:",
                        style: GoogleFonts.roboto(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.brand!,
                        style: GoogleFonts.roboto(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            Get.toNamed('/cart');
          },
          backgroundColor: Colors.brown,
          label: const Text('Add to Cart'),
          icon: const Icon(Icons.shopping_cart),
        ));
  }
}
