class DogImage {
  String imageUrl;

  DogImage(this.imageUrl);

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(json['message']);
  }
}

class DogApiResponse {
  List<DogImage> images;

  DogApiResponse(this.images);

  factory DogApiResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> imageUrls = json['message'];
    List<DogImage> images =
        imageUrls.map((imageUrl) => DogImage(imageUrl)).toList();
    return DogApiResponse(images);
  }
}
