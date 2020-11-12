class App {
  String name;
  String description;
  String linkdown;
  String logolink;
  String linkdownios;

  App(
      {this.name,
      this.description,
      this.linkdown,
      this.logolink,
      this.linkdownios});

  factory App.fromJson(dynamic data) {
    return App(
      name: data['name'],
      description: data['description'],
      linkdown: data['linkdown'],
      logolink: data['logolink'],
      linkdownios: data['linkdownios'],
    );
  }

  @override
  String toString() {
    return 'App{name: $name, description: $description, linkdown: $linkdown, logolink: $logolink, linkdownios: $linkdownios}';
  }
}
