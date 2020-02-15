class Category{
  String image, title;

  Category({this.image, this.title});

  factory Category.fromJson(Map<String, dynamic> value){
    return Category(
      image: value['image'],
      title: value['title']
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Category{image: $image, title: $title}';
  }
}