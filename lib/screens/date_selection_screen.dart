import 'package:flutter/material.dart';

import '../main.dart';
import '../models/search_request.dart';

const List<String> _kMonthNames = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class DateSelectionScreen extends StatefulWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;

  const DateSelectionScreen({super.key, this.checkIn, this.checkOut});

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  late DateTime _visibleMonth;
  DateTime? _checkIn;
  DateTime? _checkOut;

  DateTime get _today {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void initState() {
    super.initState();
    _checkIn = widget.checkIn;
    _checkOut = widget.checkOut;
    final DateTime base = widget.checkIn ?? DateTime.now();
    _visibleMonth = DateTime(base.year, base.month);
  }

  int get _nights {
    if (_checkIn == null || _checkOut == null) return 0;
    return (_checkOut!.difference(_checkIn!).inHours / 24).round();
  }

  static bool _isSameDay(DateTime? a, DateTime? b) =>
      a != null &&
      b != null &&
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;

  void _onDayTap(DateTime day) {
    setState(() {
      if (_checkIn == null || _checkOut != null) {
        // Start a fresh selection.
        _checkIn = day;
        _checkOut = null;
      } else if (day.isAfter(_checkIn!)) {
        _checkOut = day;
      } else {
        _checkIn = day;
      }
    });
  }

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canGoBack = _visibleMonth.isAfter(
      DateTime(_today.year, _today.month),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Dates',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildMonthHeader(canGoBack),
          _buildWeekdayRow(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildDayGrid(),
            ),
          ),
          _buildSummaryBar(),
        ],
      ),
    );
  }

  Widget _buildMonthHeader(bool canGoBack) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: canGoBack ? Colors.black87 : kBorderGrey,
            ),
            onPressed: canGoBack ? () => _changeMonth(-1) : null,
          ),
          Text(
            '${_kMonthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.black87),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayRow() {
    const List<String> labels = <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: labels
            .map((String d) => Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kTextGrey,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildDayGrid() {
    final int daysInMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;
    // Sunday = 0 ... Saturday = 6
    final int leadingBlanks =
        DateTime(_visibleMonth.year, _visibleMonth.month, 1).weekday % 7;
    final int cellCount = leadingBlanks + daysInMonth;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cellCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index < leadingBlanks) return const SizedBox.shrink();

        final DateTime day = DateTime(
          _visibleMonth.year,
          _visibleMonth.month,
          index - leadingBlanks + 1,
        );
        return _buildDayCell(day);
      },
    );
  }

  Widget _buildDayCell(DateTime day) {
    final bool isPast = day.isBefore(_today);
    final bool isCheckIn = _isSameDay(day, _checkIn);
    final bool isCheckOut = _isSameDay(day, _checkOut);
    final bool inRange = _checkIn != null &&
        _checkOut != null &&
        day.isAfter(_checkIn!) &&
        day.isBefore(_checkOut!);
    final bool isEdge = isCheckIn || isCheckOut;

    return GestureDetector(
      onTap: isPast ? null : () => _onDayTap(day),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: inRange ? const Color(0xFFE8F0FE) : null,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isCheckIn ? 20 : 0),
            right: Radius.circular(isCheckOut ? 20 : 0),
          ),
        ),
        child: Center(
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEdge ? kPrimaryBlue : null,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: isEdge ? FontWeight.w700 : FontWeight.w500,
                color: isEdge
                    ? Colors.white
                    : isPast
                        ? kBorderGrey
                        : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBar() {
    final bool canConfirm = _checkIn != null && _checkOut != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kBorderGrey)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                _summaryItem(
                  'Check-in',
                  _checkIn == null
                      ? '--'
                      : SearchRequest.fullDate(_checkIn!),
                ),
                _summaryItem(
                  'Check-out',
                  _checkOut == null
                      ? '--'
                      : SearchRequest.fullDate(_checkOut!),
                ),
                _summaryItem(
                  'Nights',
                  canConfirm
                      ? (_nights == 1 ? '1 NIGHT' : '$_nights NIGHTS')
                      : '--',
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: kBorderGrey,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: canConfirm
                    ? () => Navigator.pop(
                          context,
                          DateTimeRange(start: _checkIn!, end: _checkOut!),
                        )
                    : null,
                child: const Text(
                  'DONE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: kTextGrey),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
