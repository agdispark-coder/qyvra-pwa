import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeNotifier>(context).isDarkMode;
    final bgColor = isDark ? const Color(0xFF1A1A2E) : AppTheme.cream;
    final cardColor = isDark ? const Color(0xFF252545) : AppTheme.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isDark),
              const SizedBox(height: 24),
              _buildGreetingCard(isDark, cardColor),
              const SizedBox(height: 20),
              _buildCycleStatusCard(isDark, cardColor),
              const SizedBox(height: 20),
              _buildWeeklyChart(isDark, cardColor),
              const SizedBox(height: 20),
              _buildQuickActions(isDark, cardColor),
              const SizedBox(height: 20),
              _buildTipCard(isDark, cardColor),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QYVRA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryRose,
              ),
            ),
            Text(
              _getGreeting(),
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white54 : AppTheme.textLight,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.softPink,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: AppTheme.primaryRose,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning ☀️';
    if (hour < 17) return 'Good Afternoon 🌤️';
    return 'Good Evening 🌙';
  }

  Widget _buildGreetingCard(bool isDark, Color cardColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryRose, AppTheme.primaryRoseLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryRose.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Wellness Journey',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your cycle, nutrition & feel your best every day.',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.white.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatPill('Day 14', 'Cycle'),
              const SizedBox(width: 12),
              _buildStatPill('2,100', 'Cal Today'),
              const SizedBox(width: 12),
              _buildStatPill('7h 30m', 'Sleep'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: AppTheme.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleStatusCard(bool isDark, Color cardColor) {
    final phases = ['Menstrual', 'Follicular', 'Ovulation', 'Luteal'];
    final currentPhase = 2;
    final days = ['1-5', '6-13', '14-16', '17-28'];
    final colors = [
      AppTheme.primaryRose,
      AppTheme.peach,
      AppTheme.mint,
      AppTheme.lavender,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cycle Phase',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors[currentPhase].withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  phases[currentPhase],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryRose,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(4, (i) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i < 3 ? 6 : 0),
                  height: 6,
                  decoration: BoxDecoration(
                    color: i <= currentPhase
                        ? colors[i]
                        : (isDark ? Colors.white10 : Colors.grey[200]),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(4, (i) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 3 ? 6 : 0),
                  child: Column(
                    children: [
                      Text(
                        days[i],
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? Colors.white54 : AppTheme.textLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        phases[i],
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: i == currentPhase
                              ? AppTheme.primaryRose
                              : (isDark ? Colors.white38 : AppTheme.textLight),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(bool isDark, Color cardColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Week',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Calorie Intake',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white54 : AppTheme.textLight,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 2500,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            days[value.toInt()],
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : AppTheme.textLight,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _barGroup(0, 1800, isDark),
                  _barGroup(1, 2100, isDark),
                  _barGroup(2, 1950, isDark),
                  _barGroup(3, 2200, isDark),
                  _barGroup(4, 2050, isDark),
                  _barGroup(5, 2400, isDark),
                  _barGroup(6, 2100, isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double val, bool isDark) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: val,
          gradient: const LinearGradient(
            colors: [AppTheme.primaryRose, AppTheme.primaryRoseLight],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(6),
          width: 28,
        ),
      ],
    );
  }

  Widget _buildQuickActions(bool isDark, Color cardColor) {
    final actions = [
      {'icon': Icons.restaurant_menu, 'label': 'Nutrition', 'color': AppTheme.peach},
      {'icon': Icons.favorite, 'label': 'Cycle', 'color': AppTheme.softPink},
      {'icon': Icons.water_drop, 'label': 'Water', 'color': const Color(0xFFD4EEFF)},
      {'icon': Icons.self_improvement, 'label': 'Wellness', 'color': AppTheme.lavender},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: actions.map((a) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: a['color'] as Color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        a['icon'] as IconData,
                        color: AppTheme.primaryRose,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      a['label'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTipCard(bool isDark, Color cardColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryRose.withOpacity(0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.lavender,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: AppTheme.primaryRose,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Tip',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'During ovulation, your body needs extra iron and vitamin C. Try adding spinach and citrus fruits to your meals today!',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: isDark ? Colors.white60 : AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
