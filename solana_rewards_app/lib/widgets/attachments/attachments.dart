import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solana_rewards_app/models/photo_item.dart';
import 'package:image_picker/image_picker.dart';

class Attachments extends StatefulWidget {
  Attachments({Key? key, this.items}) : super(key: key);

  List<ImageProvider>? items;

  @override
  _AttachmentsState createState() => _AttachmentsState();
}

class _AttachmentsState extends State<Attachments> {

  /*final List<PhotoItem> _items = [
    PhotoItem(
        "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Stephan Seeber"),
    PhotoItem(
        "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Liam Gant"),
  ];*/

  @override
  Widget build(BuildContext context) {
    widget.items ??= [
      NetworkImage(
            "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
      NetworkImage(
            "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
      ];

    if (widget.items!.length == 0) {
      return Container();
    }

    return Container(
        decoration: BoxDecoration(
            color: Colors.white30,
            border: Border.all(color: Colors.white30),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.items!.length,
                  itemBuilder: (context, index) {
                    return _buildImage(widget.items![index]);
                  },
                ),
              ),
        ),
    );
  }

  Widget _buildImage(ImageProvider image){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
    );
  }
}
