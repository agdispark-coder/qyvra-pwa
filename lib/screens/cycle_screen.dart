import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme.dart';

class CycleScreen extends StatefulWidget {
  const CycleScreen({super.key});

  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeNotifier>(context).isDarkMode;
    final bgColor = isDark ? const Color(0xFF1A1A2E) : AppTheme.cream;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('My Cycle'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryRose,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: AppTheme.primaryRose,
          unselectedLabelColor: isDark ? Colors.white54 : AppTheme.textLight,
          tabs: const [
            Tab(text: 'Calendar'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCalendar(isDark),
          _buildHistory(isDark),
        ],
      ),
    );
  }

  Widget _buildCalendar(bool isDark) {
    final cardColor = isDark ? const Color(0xFF252545) : AppTheme.white;
    final today = DateTime.now();
    final currentDay = today.day;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryRose.withOpacity(0.1),
                  AppTheme.lavender.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$currentDay',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryRose,
                        ),
                      ),
                      Text(
                        _getMonthName(today.month),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ovulation Phase',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Day 14 of 28',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation(AppTheme.primaryRose),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'April 2025',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 12),
          _buildDayGrid(isDark, cardColor),
        ],
      ),
    );
  }

  Widget _buildDayGrid(bool isDark, Color cardColor) {
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final today = DateTime.now().day;

    return Column(
      children: [
        Row(
          children: weekDays.map((d) {
            return Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white38 : AppTheme.textLight,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        ...List.generate(5, (week) {
          final startDay = week * 7 + 1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: List.generate(7, (day) {
                final d = startDay + day;
                if (d > 30) {
                  return const Expanded(child: SizedBox(height: 44));
                }
                final isToday = d == today;
                final isPeriod = d >= 1 && d <= 5;
                final isOvulation = d >= 14 && d <= 16;

                Color? dayColor;
                if (isPeriod) dayColor = AppTheme.primaryRose;
                else if (isOvulation) dayColor = AppTheme.mint;

                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    height: 44,
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppTheme.primaryRose
                          : (dayColor ?? Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '$d',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                          color: isToday
                              ? AppTheme.white
                              : (dayColor != null
                                  ? AppTheme.textDark
                                  : (isDark ? Colors.white60 : AppTheme.textDark)),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHistory(bool isDark) {
    final cardColor = isDark ? const Color(0xFF252545) : AppTheme.white;

    final cycles = [
      {'start': 'Mar 15', 'end': 'Apr 12', 'length': '28 days', 'period': '5 days'},
      {'start': 'Feb 15', 'end': 'Mar 14', 'length': '27 days', 'period': '4 days'},
      {'start': 'Jan 18', 'end': 'Feb 14', 'length': '28 days', 'period': '5 days'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: cycles.length,
      itemBuilder: (context, index) {
        final c = cycles[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.softPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: AppTheme.primaryRose,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${c['start']} - ${c['end']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Length: ${c['length']} | Period: ${c['period']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDark ? Colors.white24 : Colors.grey[400],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
