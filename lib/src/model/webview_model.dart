enum UrlSource { web, file, asset }

class WebViewModel {
  WebViewModel(this.url,
      {this.title,
      this.filterUrl,
      this.filterTitle,
      this.source = UrlSource.web,
      this.back = true});
  String? title;
  String url;
  String? filterUrl;
  String? filterTitle;
  UrlSource source;
  bool back;
}
