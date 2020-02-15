import 'package:json_annotation/json_annotation.dart';
class ResponseTopHeadlinesNews{
  String status;
  int totalResults;
  List<Article> articles;
  @JsonKey(ignore: true)
  String error;

  ResponseTopHeadlinesNews({this.status, this.totalResults, this.articles});

  factory ResponseTopHeadlinesNews.fromJson(Map<String, dynamic> value){
    return ResponseTopHeadlinesNews(
      status: value['status'] as String,
      totalResults: value['totalResults'] as int,
      articles: (value['articles'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    );
  }

  ResponseTopHeadlinesNews.withError(this.error);

  // Map<String, dynamic> toJson() => _$ResponseTopHeadlinesNewsFromJson(this);
    
  @override
  String toString() {
    // TODO: implement toString
    return 'ResponseTopHeadlinesNews{status: $status, totalResult: $totalResults, articles: $articles, error: $error';
  }
}

class Article{
  Source source;
  String author, title, description, url, urlToImage, publishedAt, content;
  
  Article({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

  factory Article.fromJson(Map<String, dynamic> value){
    return Article(
      source: value['source'] == null
        ? null
        : Source.fromJson(value['source'] as Map<String, dynamic>),
      author: value['author'] as String,
      title: value['title'] as String,
      description: value['description'] as String,
      url: value['url'] as String,
      urlToImage: value['urlToImage'] as String,
      publishedAt: value['publishedAt'] as String,
      content: value['content'] as String,
    );
  }

  // Map<String, dynamic> toJson() => _$ArticleFromJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return 'Article{source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }
}

class Source{
  String name;
  Source({this.name});

  factory Source.fromJson(Map<String, dynamic> value) {
    return Source(
      name: value['name'] as String,
    );
  }

  // Map<String, dynamic> toJson()=> _$SourceFromJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return 'Source{name: $name}';
  }
}