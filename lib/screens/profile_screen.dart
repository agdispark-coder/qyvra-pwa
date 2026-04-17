import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(isDark),
              const SizedBox(height: 24),
              _buildStatsRow(isDark, cardColor),
              const SizedBox(height: 24),
              _buildMenuSection(context, isDark, cardColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primaryRose, AppTheme.primaryRoseLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: const Center(
            child: Text(
              'Q',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: AppTheme.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'QYVRA User',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Premium Member',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.primaryRose,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(bool isDark, Color cardColor) {
    final stats = [
      {'value': '28', 'label': 'Day Cycle'},
      {'value': '5', 'label': 'Period Days'},
      {'value': '14', 'label': 'Current Day'},
    ];

    return Row(
      children: stats.map((s) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  s['value'] as String,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryRose,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s['label'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white54 : AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMenuSection(BuildContext context, bool isDark, Color cardColor) {
    final items = [
      {'icon': Icons.person_outline, 'title': 'Edit Profile'},
      {'icon': Icons.notifications_outlined, 'title': 'Notifications'},
      {'icon': Icons.lock_outline, 'title': 'Privacy & Security'},
      {'icon': Icons.help_outline, 'title': 'Help & Support'},
      {'icon': Icons.info_outline, 'title': 'About QYVRA'},
    ];

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: AppTheme.primaryRose,
            ),
            title: Text(
              item['title'] as String,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : AppTheme.textDark,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: isDark ? Colors.white24 : Colors.grey[400],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
