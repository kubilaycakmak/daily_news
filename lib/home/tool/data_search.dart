// import 'package:daily_news/home/model/topheadlinesnews/response_top_headlines_news.dart';
// import 'package:flutter/material.dart';

// class DataSearch extends SearchDelegate<String>{
//   List<Article> articles;

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return[
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List list = articles.where((element) {
//       var listTitle = element.title.toLowerCase();
//       return listTitle.contains(query);
//   }).toList();
//     return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (context, index) => ListTile(
//         title: Text(list[index].title),
//         subtitle: Text(list[index].content),
//         leading: Icon(Icons.new_releases),
//         onTap: (){
//           print('za');
//         },
//       ),
//     );
//   }
// }