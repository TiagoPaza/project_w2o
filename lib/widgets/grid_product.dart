import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridProduct extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final Color cardColor;
  final bool isFav;

  GridProduct(
      {Key key,
      @required this.id,
      @required this.name,
      @required this.image,
      @required this.cardColor,
      this.isFav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.cardColor,
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: EdgeInsets.all(2.5),
                      child: CachedNetworkImage(
                        imageUrl: this.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset(
                          'assets/images/no_product_image.png',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -10.0,
                    bottom: 3.0,
                    child: RawMaterialButton(
                      onPressed: () {},
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          this.isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  this.name,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          //
        },
      ),
    );
  }
}
