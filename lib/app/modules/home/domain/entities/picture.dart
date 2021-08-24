class Picture {
  final String title;
  final String date;
  final String explanation;
  final String url;

  Picture({
    this.title,
    this.date,
    this.explanation,
    this.url,
  });

  @override
  String toString() {
    return 'Picture(title: $title, date: $date, explanation: $explanation, url: $url)';
  }
}
