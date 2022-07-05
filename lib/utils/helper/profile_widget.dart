import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClick;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          // Positioned(
          //   bottom: 0,
          //   right: 4,
          //   child: buildEditIcon(color),
          // ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onClick,
          child: FancyShimmerImage(
            imageUrl: imagePath,
            boxFit: BoxFit.cover,
            width: 128,
            errorWidget: Image.asset("assets/images/placeholder.png"),
            height: 128,
          ),
        ),
        // child: Ink.image(
        //   image: image,
        //   fit: BoxFit.cover,
        //   width: 128,
        //   height: 128,
        //   child: InkWell(onTap: onClicked),
        // ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class EditProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const EditProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onClicked,
          child: FancyShimmerImage(
            imageUrl: imagePath,
            boxFit: BoxFit.cover,
            width: 128,
            errorWidget: Image.asset("assets/images/placeholder.png"),
            height: 128,
          ),
        ),
        // child: Ink.image(
        //   image: image,
        //   fit: BoxFit.cover,
        //   width: 128,
        //   height: 128,
        //   child: InkWell(onTap: onClicked),
        // ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
