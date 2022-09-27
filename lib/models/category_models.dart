class Category {
  String? title;
  String? image;

  Category({required this.title,required this.image});
}

List<Category> categories = [

  Category(title: 'GROCERY', image: 'assets/c_images/a.jpg'),
  Category(title: 'ELECTRONICES', image: 'assets/c_images/b.png'),
  Category(title: 'COSMETICS', image: 'assets/c_images/c.png'),
  Category(title: 'PHARMECY', image: 'assets/c_images/d.jpg'),
  Category(title: 'GARMENTS', image: 'assets/c_images/e.png'),

];