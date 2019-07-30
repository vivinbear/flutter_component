import 'package:flutter/material.dart';
import 'dart:async';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  var _minutes = 0;
  var _seconds = 0;
  var _milliseconds = 0;
  var _countMinutes = 0;
  var _countSeconds = 0;
  var _countMilliseconds = 0;
  List<String> _countList = [];
  var _isTiming = false;
  var _leftButtonText = '复位';
  var _rightButtonText = '启动';
  var _timer;
  _handleClick(String type) {
    // 先判断是坐还是右,然后判断_isTiming是否在执行
    if (type == 'right') {
      setState(() {
        _leftButtonText = _isTiming ? '复位' : '计次';
        _rightButtonText = _isTiming ? '启动' : '停止';
      });
      if (!_isTiming) {
        var timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
          var milliseconds = _milliseconds == 99 ? 0 : _milliseconds + 1;
          var seconds = _milliseconds == 99 && _seconds == 59
              ? 0
              : _milliseconds == 99 ? _seconds + 1 : _seconds;
          var minutes =
              _milliseconds == 99 && _seconds == 59 ? _minutes + 1 : _minutes;
          var countMilliseconds =
              _countMilliseconds == 99 ? 0 : _countMilliseconds + 1;
          var countSeconds = _countMilliseconds == 99 && _countSeconds == 59
              ? 0
              : _countMilliseconds == 99 ? _countSeconds + 1 : _countSeconds;
          var countMinutes = _countMilliseconds == 99 && _countSeconds == 59
              ? _countMinutes + 1
              : _countMinutes;
          setState(() {
            _milliseconds = milliseconds;
            _seconds = seconds;
            _minutes = minutes;
            _countMilliseconds = countMilliseconds;
            _countSeconds = countSeconds;
            _countMinutes = countMinutes;
          });
        });
        setState(() {
          _isTiming = !_isTiming;
          _timer = timer;
        });
      } else {
        _timer.cancel();
        setState(() {
          _isTiming = !_isTiming;
        });
      }
    } else if (type == 'left') {
      if (!_isTiming) {
        _timer.cancel();
        setState(() {
          _milliseconds = 0;
          _seconds = 0;
          _minutes = 0;
          _timer = null;
          _countList = [];
          _countMilliseconds = 0;
          _countSeconds = 0;
          _countMinutes = 0;
          _leftButtonText = _isTiming ? '计次' : '复位';
          _rightButtonText = _isTiming ? '停止' : '启动';
          _isTiming = false;
        });
      } else {
        var list = List<String>();
        setState(() {
          _countList = list
            ..addAll(_countList)
            ..add(
                '${_doubletime(_countMinutes)}:${_doubletime(_countSeconds)}.${_doubletime(_countMilliseconds)}');
          _countMilliseconds = 0;
          _countSeconds = 0;
          _countMinutes = 0;
        });
      }
    }
  }

  _doubletime(int time) => time <= 9 ? '0$time' : '$time';
  Widget _renderTimeList(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10.0),
      height: 44.0,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xff333333),
            width: 1.0,
          ),
          bottom: BorderSide(
            color: Color(0xff333333),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('计时器'),
          // leading: Icon(Icons.arrow_back),
        ),
        body: Container(
          color: Color(0xff0d0d0d),
          child: Column(
            children: <Widget>[
              Container(
                height: 268.0,
                width: double.infinity,
                child: Center(
                  child: Text(
                    '${_doubletime(_minutes)}:${_doubletime(_seconds)}.${_doubletime(_milliseconds)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: 100.0,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _handleClick('left');
                      },
                      child: Container(
                        width: 84.0,
                        height: 84.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _leftButtonText == '计次'
                              ? Color(0xff141414)
                              : Color(0xff3d3d3d),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _leftButtonText,
                          style: TextStyle(
                            color: _leftButtonText == '计次'
                                ? Color(0xff8e8e92)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _handleClick('right');
                      },
                      child: Container(
                        width: 84.0,
                        height: 84.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _rightButtonText == '启动'
                              ? Color(0xff203521)
                              : Color(0xff391815),
                        ),
                        child: Text(
                          _rightButtonText,
                          style: TextStyle(
                            color: _rightButtonText == '启动'
                                ? Color(0xff76d672)
                                : Color(0xffea4e3d),
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                height: 44.0,
                child: Text(
                  '${_doubletime(_countMinutes)}:${_doubletime(_countSeconds)}.${_doubletime(_countMilliseconds)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xff333333),
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xff333333),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: ListView(
                    children: _countList
                        .map((item) => _renderTimeList(item))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
