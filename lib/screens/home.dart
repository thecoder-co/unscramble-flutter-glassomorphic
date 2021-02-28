import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _value = '';
  List _foundWords = [];
  List _foundWords3 = [];
  List _foundWords4 = [];
  List _foundWords5 = [];
  List _foundWords6 = [];
  List _foundWords7 = [];

  void _onSubmit(String value) {
    setState(() => _value = value);
  }

  void _onChange(String value) {
    setState(() => _value = value);
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/texts/words_alpha.txt');
  }

  List<Widget> _widgetOptions() => <Widget>[
        _OptionOne(
          onUnscramble: () async {
            print(_value);
            List _toList(String lily) {
              List a = [];
              for (var i = 0; i < lily.length; i++) {
                a.add(lily[i]);
              }

              return a;
            }

            int freql(var w, List lst) {
              int count = 0;
              for (var i = 0; i < lst.length; i++) {
                if (lst[i] == w) {
                  count += 1;
                }
              }
              return count;
            }

            bool isin(String lily, String ylil) {
              List a = _toList(lily);
              List b = _toList(ylil);
              for (var i = 0; i < a.length; i++) {
                if (!b.contains(a[i])) {
                  return false;
                }
              }
              for (var i = 0; i < a.length; i++) {
                if (freql(a[i], a) > freql(b[i], b)) {
                  return false;
                }
              }
              return true;
            }

            List foundWords = [];
            String fileContent = await loadAsset();
            List wordList = fileContent.split('\n');
            List necessaryWords = [];

            for (String i in wordList) {
              List lst = Iterable<int>.generate(_value.length + 1).toList();
              if (lst.contains(i.length)) {
                necessaryWords.add(i);
              }
            }

            for (var j in necessaryWords) {
              if (isin(j, _value)) {
                foundWords.add(j);
              }
            }
            setState(() {
              _foundWords = [];
              _foundWords3 = [];
              _foundWords4 = [];
              _foundWords5 = [];
              _foundWords6 = [];
              _foundWords7 = [];
            });
            _foundWords = foundWords;
            for (var i in foundWords) {
              if (i.length == 3) {
                _foundWords3.add(i);
              } else if (i.length == 4) {
                _foundWords4.add(i);
              } else if (i.length == 5) {
                _foundWords5.add(i);
              } else if (i.length == 6) {
                _foundWords6.add(i);
              } else if (i.length == 7) {
                _foundWords7.add(i);
              }
            }
          },
          onChange: _onChange,
          onSubmit: _onSubmit,
        ),
        _OptionTwo(
          value: _value,
          foundWords: _foundWords,
          foundWords3: _foundWords3,
          foundWords4: _foundWords4,
          foundWords5: _foundWords5,
          foundWords6: _foundWords6,
          foundWords7: _foundWords7,
        )
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/glass_bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            backgroundColor: Colors.white.withOpacity(0),
            appBar: PreferredSize(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    title: Text(
                      'Unscramble',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              preferredSize: Size(
                double.infinity,
                56.0,
              ),
            ),
            body: Center(
              child: _widgetOptions().elementAt(_selectedIndex),
            ),
            bottomNavigationBar: PreferredSize(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    selectedItemColor: Colors.black,
                    onTap: _onItemTapped,
                    currentIndex: _selectedIndex,
                    elevation: 0,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.pending_actions),
                        label: 'Unscramble',
                      ),
                    ],
                  ),
                ),
              ),
              preferredSize: Size(
                double.infinity,
                56.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionOne extends StatelessWidget {
  final Function onUnscramble;
  final Function onChange;
  final Function onSubmit;

  _OptionOne({this.onUnscramble, this.onChange, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              spreadRadius: 3,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 40.0,
              sigmaY: 40.0,
            ),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Input Letters',
                        ),
                        autocorrect: true,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        onSubmitted: onSubmit,
                        onChanged: onChange,
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              'Unscramble',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              onUnscramble();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionTwo extends StatelessWidget {
  final String value;
  final List foundWords;
  final List foundWords3;
  final List foundWords4;
  final List foundWords5;
  final List foundWords6;
  final List foundWords7;

  _OptionTwo(
      {this.value = '',
      this.foundWords,
      this.foundWords3,
      this.foundWords4,
      this.foundWords5,
      this.foundWords6,
      this.foundWords7});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Three Letter Words',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 3,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Container(
                    height: foundWords3.length == 0 ? 75 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: foundWords3.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: ListTile(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: foundWords3[index],
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${foundWords3[index]} copied to clipboard'),
                                  ),
                                );
                              },
                              dense: true,
                              title: Center(
                                child: Text(
                                  foundWords3[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Four Letter Words',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 3,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Container(
                    height: foundWords4.length == 0 ? 75 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: foundWords4.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: ListTile(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: foundWords4[index],
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${foundWords4[index]} copied to clipboard'),
                                  ),
                                );
                              },
                              dense: true,
                              title: Center(
                                child: Text(
                                  foundWords4[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Five Letter Words',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 3,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Container(
                    height: foundWords5.length == 0 ? 75 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: foundWords5.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: ListTile(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: foundWords5[index],
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${foundWords5[index]} copied to clipboard'),
                                  ),
                                );
                              },
                              dense: true,
                              title: Center(
                                child: Text(
                                  foundWords5[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Six Letter Words',
            style: TextStyle(
              backgroundColor: Colors.white.withOpacity(0),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 3,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Container(
                    height: foundWords6.length == 0 ? 75 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: foundWords6.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: ListTile(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: foundWords6[index],
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${foundWords6[index]} copied to clipboard'),
                                  ),
                                );
                              },
                              dense: true,
                              title: Center(
                                child: Text(
                                  foundWords6[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Seven Letter Words',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 3,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Container(
                    height: foundWords7.length == 0 ? 75 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: foundWords7.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: ListTile(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: foundWords7[index],
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${foundWords7[index]} copied to clipboard'),
                                  ),
                                );
                              },
                              dense: true,
                              title: Center(
                                child: Text(
                                  foundWords7[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'All Letter Words',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 3,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Container(
                    height: foundWords.length == 0 ? 75 : 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: foundWords.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: ListTile(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: foundWords[index],
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${foundWords[index]} copied to clipboard'),
                                  ),
                                );
                              },
                              dense: true,
                              title: Center(
                                child: Text(
                                  foundWords[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
