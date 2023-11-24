import 'package:cached_network_image/cached_network_image.dart';
import 'package:dummy_api/api_service/http_service.dart';
import 'package:dummy_api/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'item_detail.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: fetchItemData(category: category),
      builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return InkWell(
                  child: Card(
                    elevation: 3,
                    // Define the shape of the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // Define how the card's content should be clipped
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // Define the child widget of the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add padding around the row widget
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Add an image widget to display an image
                              CachedNetworkImage(
                                imageUrl: product.thumbnail!,
                                width: 80,
                                height: 80.0,
                                fit: BoxFit.contain,
                              ),
                              // Add some spacing between the image and the text
                              Container(width: 20),
                              // Add an expanded widget to take up the remaining horizontal space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Add some spacing between the top of the card and the title
                                    Container(height: 5),
                                    // Add a title widget
                                    Text(
                                      product.title!,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    // Add some spacing between the title and the subtitle
                                    Container(height: 5),
                                    // Add a subtitle widget
                                    Text(
                                      '\$ ${product.price.toString()}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Add some spacing between the subtitle and the text
                                    Container(height: 10),
                                    // Add a text widget to display text
                                    Text(
                                      product.category.toString(),
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                  child: IconButton(
                                icon: const Icon(Icons.add_card_sharp),
                                onPressed: () {},
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ItemsDetail(id: product.id!),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
