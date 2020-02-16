import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news/home/api/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:daily_news/home/bloc/home_bloc.dart';
import 'package:daily_news/home/model/category/category.dart';
import 'package:daily_news/home/model/topheadlinesnews/response_top_headlines_news.dart';
import 'package:daily_news/home/ui/style/color.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
String globalTitle = 'Hepsi';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(" ")[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + "st";
    } else if (strDay == '2') {
      strDay = strDay + "nd";
    } else if (strDay == '3') {
      strDay = strDay + "rd";
    } else {
      strDay = strDay + "th";
    }
    var strMonth = today.split(" ")[0];
    // if(strMonth == 'February'){
    //   strMonth = 'Şubat';
    // }
    var strYear = today.split(" ")[2];
    return "$strDay $strMonth $strYear";
  }

  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: scaffoldState,
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: colorDarkLighter,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25)
                )
              ),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 16.0,
                bottom: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  WidgetCategory()
                ],
              ),
            ),
            SizedBox(height: 12.0,),
            SizedBox(height: 12.0,),
            _buildWidgetLabelLatestNews(context, globalTitle),
            _buildWidgetSubtitleLatestNews(context),
            Expanded(
              child: WidgetLatestNews(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildWidgetSubtitleLatestNews(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        '',
        style: Theme.of(context).textTheme.caption.merge(
          TextStyle(
            color: colorDark
          )
        ),
      ),
    );
  }

  Widget _buildWidgetLabelLatestNews(BuildContext context, String titleLabel){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        '$titleLabel',
        style: Theme.of(context).textTheme.subtitle.merge(
          TextStyle(
            fontSize: 18.0,
            letterSpacing: 1,
            color: colorDark
          )
        ),
      ),
    );
  }
  
}

class WidgetTitle extends StatelessWidget {
  final String strToday;
  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Bugün\n',
                    style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        color: colorGray,
                        letterSpacing: 2
                      )
                    )
                  ),
                  TextSpan(
                    text: strToday,
                    style: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                        color: colorGrayTransparent,
                        fontSize: 13.0
                      )
                    )
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_horiz, size: 20, color: colorGray,),
              onPressed: (){
              },
            ),
          ],
        )
      ),
    );
  }
}

class WidgetCategory extends StatefulWidget {
  WidgetCategory({Key key}) : super(key: key);

  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  TextEditingController _searchQueryController = new TextEditingController();
  bool isSearch = false;
  double dynamicWidth = 68.0;
  int indexSelectedCategory = 0;
  final listCategories = [
    Category(image: '', title: 'All'),
    Category(image: '', title: 'Search'),
    Category(image: 'assets/img_sport.png', title: 'Sport'),
    Category(image: 'assets/img_health.png', title: 'Health'),
    Category(image: 'assets/img_technology.png', title: 'Technology'),
    Category(image: 'assets/img_science.png', title: 'Science'),
    Category(image: 'assets/img_business.png', title: 'Business'),
    Category(image: 'assets/img_entertainment.png', title: 'Entertainment'),
  ];

  @override
  void initState() {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(DataEvent(listCategories[indexSelectedCategory].title));
    print(listCategories[indexSelectedCategory].title);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      height: 80,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          Category itemCategory = listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: index == listCategories.length - 1 ? 16.0 : 0.0
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      indexSelectedCategory = index;
                      globalTitle = listCategories[indexSelectedCategory].title;
                      print(globalTitle);
                      if(index == 1){
                        dynamicWidth = 190;
                      }else{
                        dynamicWidth = 68.0;
                      }
                      homeBloc.add(DataEvent(
                        listCategories[indexSelectedCategory].title
                      ));
                    });
                  },
                  child: 
                  index == 1 ? AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 150),
                      width: dynamicWidth,
                      height: 53.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF5F5F5F),
                        border: indexSelectedCategory == index
                          ? Border.all(
                              color: colorTeal,
                              width: 2.0,
                            ): null
                      ),
                      child: dynamicWidth == 68.0 ? Icon(Icons.search,
                      color: colorWhite,)
                      :
                      Expanded(
                          child: 
                          TextFormField(
                            controller: _searchQueryController,
                            decoration: InputDecoration(
                              hintText: 'Aradığınızı bulalım ?',
                              hintStyle: TextStyle(
                                color: colorDarkLighter,
                                fontSize: 20
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5),
                              enabledBorder: InputBorder.none,
                            ),
                            cursorColor: colorDark,
                            keyboardAppearance: Brightness.dark,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                              color: colorDark,
                              fontSize: 20
                            ),
                          ),
                        ),
                      )
                  :
                  index == 0
                  ? Container(
                    width: 68.0,
                    height: 53.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFF5F5F5F),
                      border: indexSelectedCategory == index
                        ? Border.all(
                            color: colorTeal,
                            width: 2.0,
                          ): null
                    ),
                    child: Icon(Icons.apps,
                    color: colorWhite,),
                    )
                  : Container(
                    width: 68.0,
                    height: 53.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage(itemCategory.image),
                        fit: BoxFit.cover,
                      ),
                      border: indexSelectedCategory == index
                          ? Border.all(
                              color: colorTeal,
                              width: 2.0,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 8.0,),
                Text(
                  "${itemCategory.title == 'All' ? 'Hepsi' : itemCategory.title == 'Sport' ? 'Spor' : itemCategory.title == 'Health' ? 'Sağlık' : itemCategory.title == 'Technology' ? 'Teknoloji' : itemCategory.title == 'Science' ? 'Bilim' : itemCategory.title == 'Business' ? 'İş' : itemCategory.title == 'Entertainment' ? 'Eğlence' : ''}",
                  style: TextStyle(
                    fontSize: 14, 
                    color: colorGray,
                    fontWeight: indexSelectedCategory == index ?
                    FontWeight.w500 : FontWeight.w400
                  ),
                ),
                isSearch == false ? Container() : _buildWidgetSearch()
              ],
            ),
          );
        },
        itemCount: listCategories.length,
      ),
    );
  }
  Widget _buildWidgetSearch(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: (){
          // showSearch(context: context, delegate: DataSearch(
          // ));
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 12.0,
            top:8.0,
            right:12.0,
            bottom:8.0
          ),
          decoration: BoxDecoration(
            border: Border.all(color: colorDark, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: colorTeal,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: 
                TextFormField(
                  controller: _searchQueryController,
                  decoration: InputDecoration(
                    hintText: 'Aradığınızı bulalım ?',
                    hintStyle: TextStyle(
                      color: colorDarkLighter,
                      fontSize: 20
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    enabledBorder: InputBorder.none,
                  ),
                  cursorColor: colorDark,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: colorDark,
                    fontSize: 20
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  print(_searchQueryController.text);
                  globalTitle = 'Arama Sonucu';
                },
                color: colorDark,
              ),
            ],
          ),
        ),
      )
    );
  }
}
class WidgetLatestNews extends StatefulWidget {
  WidgetLatestNews();

  @override
  _WidgetLatestNewsState createState() => _WidgetLatestNewsState();
}

class _WidgetLatestNewsState extends State<WidgetLatestNews> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: BlocListener<HomeBloc, DataState>(
        listener: (context, state) {
          if (state is DataFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder(
          bloc: homeBloc,
          builder: (BuildContext context, DataState state) {
            return _buildWidgetContentLatestNews(state, mediaQuery);
          },
        ),
      ),
    );
  }

  Widget _buildWidgetContentLatestNews(
      DataState state, MediaQueryData mediaQuery) {
    if (state is DataLoading) {
      return Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(),
      );
    } else if (state is DataSuccess) {
      ResponseTopHeadlinesNews data = state.data;
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: data.articles.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          Article itemArticle = data.articles[index];
          if (index == 0) {
            return Stack(
              children: <Widget>[
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: itemArticle.urlToImage,
                    height: 192.0,
                    width: mediaQuery.size.width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(itemArticle.url)) {
                      await launch(itemArticle.url);
                    } else {
                      scaffoldState.currentState.showSnackBar(SnackBar(
                        content: Text('Could not launch news'),
                      ));
                    }
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 192.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.7,
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        top: 12.0,
                        right: 12.0,
                      ),
                      child: Text(
                        itemArticle.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        top: 4.0,
                        right: 12.0,
                      ),
                      child: Wrap(
                        children: <Widget>[
                          Icon(
                            Icons.launch,
                            color: Colors.white.withOpacity(0.8),
                            size: 12.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '${itemArticle.source.name}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () async {
                if (await canLaunch(itemArticle.url)) {
                  await launch(itemArticle.url);
                }
              },
              child: Container(
                width: mediaQuery.size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 72.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              itemArticle.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF325384),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.launch,
                                  size: 12.0,
                                  color: Color(0xFF325384).withOpacity(0.5),
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  itemArticle.source.name,
                                  style: TextStyle(
                                    color: Color(0xFF325384).withOpacity(0.5),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ClipRRect(
                        
                        // child: Image.network(
                        //   itemArticle.urlToImage ??
                        //       'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                        //   width: 72.0,
                        //   height: 72.0,
                        //   fit: BoxFit.cover,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: itemArticle.urlToImage ??
                               'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 72.0,
                            height: 72.0,
                            child: Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/img_not_found.jpg',
                            fit: BoxFit.cover,
                            width: 72.0,
                            height: 72.0,
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }
}