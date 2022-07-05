import 'package:flutter/material.dart';

class ListItemWidget extends StatefulWidget {
  final String text;
  final Animation<double> animation;
  VoidCallback? onClicked;
  bool editable;
  ListItemWidget(
      {Key? key,
      required this.text,
      required this.animation,
      this.onClicked,
      this.editable = true})
      : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey[300]),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          title: Text(
            widget.text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          trailing: widget.editable
              ? IconButton(icon: Icon(Icons.close), onPressed: widget.onClicked)
              : Text(""),
        ),
      ),
    );
  }
}
