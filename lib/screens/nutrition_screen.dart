import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/theme.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeNotifier>(context).isDarkMode;
    final bgColor = isDark ? const Color(0xFF1A1A2E) : AppTheme.cream;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Nutrition'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalorieCard(isDark),
            const SizedBox(height: 20),
            _buildMacrosChart(isDark),
            const SizedBox(height: 20),
            _buildMealLog(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieCard(bool isDark) {
    final cardColor = isDark ? const Color(0xFF252545) : AppTheme.white;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryRose, AppTheme.primaryRoseDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Today\'s Calories',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '1,680',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.white,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '/ 2,100 kcal',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 1680 / 2100,
              backgroundColor: AppTheme.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation(AppTheme.white),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '420 kcal remaining',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacrosChart(bool isDark) {
    final cardColor = isDark ? const Color(0xFF252545) : AppTheme.white;
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
            'Macronutrients',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 45,
                    title: 'Carbs\n45%',
                    color: AppTheme.primaryRose,
                    radius: 70,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 30,
                    title: 'Protein\n30%',
                    color: AppTheme.primaryRoseLight,
                    radius: 70,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 25,
                    title: 'Fat\n25%',
                    color: AppTheme.lavender,
                    radius: 70,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
                sectionsSpace: 3,
                centerSpaceRadius: 0,
                pieTouchData: PieTouchData(enabled: false),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _macroItem('Carbs', '189g', AppTheme.primaryRose),
              _macroItem('Protein', '126g', AppTheme.primaryRoseLight),
              _macroItem('Fat', '47g', AppTheme.lavender),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macroItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 11, color: AppTheme.textLight),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMealLog(bool isDark) {
    final cardColor = isDark ? const Color(0xFF252545) : AppTheme.white;
    final meals = [
      {
        'name': 'Breakfast',
        'time': '8:00 AM',
        'cal': '450 kcal',
        'items': 'Oatmeal, Banana, Almonds',
        'icon': Icons.wb_sunny_outlined,
        'color': AppTheme.peach,
      },
      {
        'name': 'Lunch',
        'time': '12:30 PM',
        'cal': '620 kcal',
        'items': 'Grilled Chicken, Rice, Salad',
        'icon': Icons.lunch_dining,
        'color': AppTheme.mint,
      },
      {
        'name': 'Snack',
        'time': '4:00 PM',
        'cal': '210 kcal',
        'items': 'Greek Yogurt, Berries',
        'icon': Icons.cookie,
        'color': AppTheme.lavender,
      },
      {
        'name': 'Dinner',
        'time': '7:30 PM',
        'cal': '400 kcal',
        'items': 'Salmon, Quinoa, Vegetables',
        'icon': Icons.dinner_dining,
        'color': AppTheme.softPink,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Meals',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 12),
        ...meals.map((m) {
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
                    color: m['color'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    m['icon'] as IconData,
                    color: AppTheme.primaryRose,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            m['name'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          Text(
                            m['cal'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.primaryRose,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        m['items'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : AppTheme.textLight,
                        ),
                      ),
                      Text(
                        m['time'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? Colors.white38 : AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
