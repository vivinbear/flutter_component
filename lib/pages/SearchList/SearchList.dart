import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  var _searchList = [];
  var _filterSearchList = [];
  _renderList() => _filterSearchList
      .map(
        (item) => Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10.0),
          height: 44.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xff333333),
                width: 1.0,
              ),
            ),
          ),
          child: Text(item),
        ),
      )
      .toList();
  @override
  void initState() {
    super.initState();
    var list = List(100);
    var searchList = [];
    for (var i = 0; i < list.length; i++) {
      searchList.add(WordPair.random().asCamelCase);
    }
    setState(() {
      _searchList = searchList;
      _filterSearchList = searchList;
    });
    print(_searchList);
  }

  _search(String value) {
    var filterSearchList = [];
    if (value.isEmpty) {
      setState(() {
        _filterSearchList = _searchList;
      });
      return;
    }
    for (var i = 0; i < _searchList.length; i++) {
      if (_searchList[i].contains(value)) {
        filterSearchList.add(_searchList[i]);
      }
    }
    setState(() {
      _filterSearchList = filterSearchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表搜索'),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.green,
        child: Column(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                onFieldSubmitted: _search,
                decoration: InputDecoration(
                  hintText: '请输入搜索内容',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                // padding: EdgeInsets.all(10.0),
                children: _renderList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
