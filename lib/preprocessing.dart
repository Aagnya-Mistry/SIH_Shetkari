import 'dart:io';
import 'package:image/image.dart' as img;

class Preprocessing {
  static img.Image preprocessImage(File image) {
    // Decode and resize the image
    img.Image? imageBytes = img.decodeImage(image.readAsBytesSync());
    img.Image resizedImage =
        img.copyResize(imageBytes!, width: 224, height: 224);

    // Normalize the image to 0-1
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        resizedImage.setPixel(x, y, resizedImage.getPixel(x, y) ~/ 255);
      }
    }

    return resizedImage;
  }
}
